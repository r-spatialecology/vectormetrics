#' @title AREA (patch level)
#'
#' @description Patch area (Area and edge metric)
#' @param landscape sf* object.
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#'
#' @details
#' \deqn{AREA = a_{ij} * (\frac{1} {10000})}
#' where \eqn{a_{ij}} is the area in square meters.
#'
#' AREA is an 'Area and edge metric' and equals the area of each patch in hectares.
#' The lower limit of AREA is limited by the resolution of the input raster,
#' i.e. AREA can't be smaller than the resolution squared (in hectares). It is one of
#' the most basic, but also most important metrics, to characterise a landscape. The
#' metric is the simplest measure of composition.
#'
#' \subsection{Units}{Hectares}
#' \subsection{Range}{AREA > 0}
#' \subsection{Behaviour}{Increases, without limit, as the patch size increases.}
#'
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_area(vector_patches, "class", "patch")
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html
#' @export

vm_p_area <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # compute area and divide by 10000 to get hectare
  landscape$area <- sf::st_area(landscape) / 10000

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("area", nrow(landscape)),
    value = as.double(landscape$area)
  ))
}
