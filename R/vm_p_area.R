#' AREA (patch level)
#'
#' @description Patch area (Area and edge metric)
#'
#' @param landscape sf* object.
#' @param class Column in sf* object indicating the land use type
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
#' @return tibble
#'
#' @examples
#' vm_p_area(vector_landscape, "class")
#'
#' @aliases vm_p_area
#' @rdname vm_p_area
#'
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html
#'
#' @name vm_p_area
#' @export

vm_p_area <- function(landscape, class) {

  # check if x argument is a multipolygon or polygon
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- dplyr::select(landscape, !!class)

  # if multipolygon, cast to single polygons (patch level)
  landscape_cast <- sf::st_cast(landscape, "POLYGON", warn = FALSE)

  # compute area and divide by 10000 to get hectare
  landscape_cast$area <- sf::st_area(landscape_cast) / 10000

  # return results tibble
  tibble::tibble(
    level = "patch",
    class = as.numeric(as.character(landscape_cast$class)),
    id = as.integer(seq_len(nrow(landscape_cast))),
    metric = "area",
    value = as.double(landscape_cast$area)
  )
}
