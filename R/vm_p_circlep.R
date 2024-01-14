#' @title Perimeter of equal-area circle(vector data)
#'
#' @description Calculate perimeter of equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  perimeter of equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' @export

vm_p_circlep <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  circle_perims <- sqrt(landscape$area / pi) * 2 * pi

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("circle_perim", nrow(landscape)),
    value = as.double(circle_perims)
  ))
}
