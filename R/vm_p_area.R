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
#' vm_p_area(landscape, class)
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

vm_p_area <- function(landscape, class){
  # if multipolygon, cast to single polygons (patch level)
  landscape_cast <- sf::st_cast(landscape, "POLYGON")

  # compute area and divide by 10000 to get hectare
  landscape_cast$area <- sf::st_area(landscape_cast) / 10000

  # drop geometry and get patch id
  landscape_tibble         <- sf::st_set_geometry(landscape_cast, NULL)
  landscape_tibble_grouped <- dplyr::group_by(landscape_tibble, class)
  landscape_tibble         <- dplyr::mutate(landscape_tibble_grouped,
                                            id = dplyr::row_number())

  tibble::tibble(
    level = "patch",
    class = as.integer(landscape_tibble$class),
    id = as.integer(landscape_tibble$id),
    metric = "area",
    value = as.double(landscape_tibble$area)
  )
}
