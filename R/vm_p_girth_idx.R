#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between radius of maximum inscribed circle and radius of equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_girth_idx(vector_landscape, "class")
#' @export

vm_p_girth_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # calculate the maximum inscribed circle radius
  insc_circle_area <- landscape |> sf::st_geometry() |> sf::st_inscribed_circle() |> sf::st_area()
  landscape$insc_circle_rad <- sqrt(insc_circle_area[1:nrow(landscape)] / pi)

  # calculate the radius of equal-area circle
  landscape$radius <- vm_p_circlep(landscape, class)$value / (2 * pi)

  # ratio of perimeter of equal-area circle and polygon perimeters
  girth_index <- landscape$insc_circle_rad / landscape$radius

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("girth_index", nrow(landscape)),
    value = as.double(girth_index)
  ))
}
