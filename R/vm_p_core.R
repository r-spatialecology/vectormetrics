#' CORE (patch level)
#'
#' @description Core area (Core area metric)
#'
#' @param landscape *sf* MULTIPOLYGON or POLYGON feature
#' @param class_col Name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @param edge_depth Distance (in map units) a location has the be away from the patch edge to be considered as core location
#'
#' @details
#' \deqn{CORE = a_{ij}^{core}}
#' where \eqn{a_{ij}^{core}} is the core area in square meters
#'
#' CORE is a 'Core area metric' and equals the area within a patch that is not
#' on the edge of it. A location is defined as core area if the location has no
#' neighbour with a different value than itself. It describes patch area
#' and shape simultaneously (more core area when the patch is large and the shape is
#' rather compact, i.e. a square).
#'
#' \subsection{Units}{Hectares}
#' \subsection{Range}{CORE >= 0}
#' \subsection{Behaviour}{Increases, without limit, as the patch area increases
#' and the patch shape simplifies (more core area). CORE = 0 when every location in
#' the patch is an edge.}
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_core(vector_patches, "class", "patch", edge_depth = 0.8)
#'
#' @aliases vm_p_core
#' @rdname vm_p_core
#'
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html

#' @name vm_p_core
#' @export

vm_p_core <- function(landscape, class_col = NULL, patch_col = NULL, edge_depth) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  #create the core areas using st_buffer with a negetive distance to the edge of polygons
  core_area <- sf::st_buffer(landscape, dist = -edge_depth)

  # calculate the area of each core area
  landscape$core <- sf::st_area(core_area) / 10000

  # return result tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("core", nrow(landscape)),
    value = as.double(landscape$core)
  ))
}
