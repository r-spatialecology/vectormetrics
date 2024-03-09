#' @title CIRCLE (patch level)
#'
#' @description Related Circumscribing Circle (Shape metric)
#' @param landscape *sf* MULTIPOLYGON or POLYGON feature
#' @param class_col Name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#'
#' @details
#' \deqn{CIRCLE = 1 - (\frac{a_{ij}} {a_{ij}^{circle}})}
#' where \eqn{a_{ij}} is the area in square meters and \eqn{a_{ij}^{circle}} the area of
#' the smallest circumscribing circle.
#'
#' CIRCLE is a 'Shape metric'. The metric is the ratio between the patch area and the smallest
#' circumscribing circle of the patch. The diameter of the smallest circumscribing circle is
#' the 'diameter' of the patch connecting the opposing corner points of the polygon
#' that are the furthest away from each other. The metric characterises the compactness
#' of the patch and is comparable among patches with different area.
#'
#' \subsection{Units}{None}
#' \subsection{Range}{0 <= CIRCLE < 1}
#' \subsection{Behaviour}{CIRCLE = 0 for a circular patch and approaches CIRCLE = 1 for
#' a linear patch.}
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_circle(vector_patches, "class", "patch")
#'
#' @references
#' McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial Pattern Analysis
#' Program for Categorical and Continuous Maps. Computer software program produced by
#' the authors at the University of Massachusetts, Amherst. Available at the following
#' web site: http://www.umass.edu/landeco/research/fragstats/fragstats.html
#'
#' Baker, W. L., and Y. Cai. 1992. The r.le programs for multiscale analysis of
#' landscape structure using the GRASS geographical information system.
#' Landscape Ecology 7: 291-302.
#' @export

vm_p_circle <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # calculate diameter of smallest circumscribing circle
  dis_max <- vm_p_circum(landscape, class_col, patch_col)$value

  # calculate circle metric
  circle_area <- vm_p_area(landscape, class_col, patch_col)$value * 10000
  circum_area <- pi * (dis_max / 2) ^ 2
  landscape$circle <- 1 - (circle_area / circum_area)

  # return result tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("circle", nrow(landscape)),
    value = as.double(landscape$circle)
  ))

}
