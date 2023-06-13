#' CORE (patch level)
#'
#' @description Core area (Core area metric)
#'
#' @param landscape *sf* MULTIPOLYGON or POLYGON feature
#' @param class Name of the class column of the input landscape
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
#'
#' @examples
#' vm_p_core(vector_landscape, "class", edge_depth = 0.8)
#'
#' @aliases vm_p_core
#' @rdname vm_p_core
#'
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html
#'
#' @export
vm_p_core <- function(landscape, class, edge_depth) UseMethod("vm_p_core")

#' @name vm_p_core
#' @export
vm_p_core.sf <- function(landscape, class, edge_depth) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- get_patches.sf(landscape, class, 4)

  #create the core areas using st_buffer with a negetive distance to the edge of polygons
  core_area <- sf::st_buffer(landscape, dist = -edge_depth)

  # calculate the area of each core area
  landscape$core <- sf::st_area(core_area) / 10000

  # get class ids and if factor, coerce to numeric
  class_ids <-  sf::st_set_geometry(landscape, NULL)[, class]
  if (class(class_ids) == "factor"){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  # return result tibble
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = landscape$patch,
    #id = as.integer(1:nrow(landscape)),
    metric = "core",
    value = as.double(landscape$core)
  )
}

#' @name vm_p_core
#' @export
vm_p_core.SpatialPolygonsDataFrame <- function(landscape, class, edge_depth) {

  landscape <- sf::st_as_sf(landscape)
  vm_p_core(landscape, class, edge_depth)

}
