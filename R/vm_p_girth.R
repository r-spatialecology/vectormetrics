#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @details ratio between radius of maximum inscribed circle and radius of equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_girth(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_girth <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  # calculate the maximum inscribed circle radius
  insc_circle_area <- landscape |> sf::st_geometry() |> sf::st_inscribed_circle() |> sf::st_area()
  landscape$insc_circle_rad <- sqrt(insc_circle_area[1:nrow(landscape)] / pi)

  # calculate the radius of equal-area circle
  landscape$radius <- vm_p_eac_perim(landscape, class)$value / (2 * pi)

  # ratio of perimeter of equal-area circle and polygon perimeters
  girth_index <- landscape$insc_circle_rad / landscape$radius

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("girth_index", nrow(landscape)),
    value = as.double(girth_index)
  ))
}
