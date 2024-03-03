#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @details ratio between radius of maximum inscribed circle and radius of equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_girth(vector_patches, "class", "patch")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_girth <- function(landscape, class = NA, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  # calculate the maximum inscribed circle radius
  insc_circle_area <- landscape |> sf::st_geometry() |> sf::st_inscribed_circle() |> sf::st_area()
  landscape$insc_circle_rad <- sqrt(insc_circle_area[1:nrow(landscape)] / pi)

  # calculate the radius of equal-area circle
  landscape$radius <- vm_p_eac_perim(landscape, class, patch_id)$value / (2 * pi)

  # ratio of perimeter of equal-area circle and polygon perimeters
  girth_index <- landscape$insc_circle_rad / landscape$radius

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("girth_index", nrow(landscape)),
    value = as.double(girth_index)
  ))
}
