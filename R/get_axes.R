#' @title Get major and minor axis
#'
#' @description Get major axis (longest line between vertices) and minor axis (longest line inside a shape that is perpendicular to major axis) of polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return sf object with exploded polygons
#' @examples
#' get_axes(vector_landscape, "class")
#' @name get_axes
#' @export

get_axes <- function(landscape, class){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  for (row in 1:nrow(landscape)) {
    points <- landscape[row, ] |> sf::st_minimum_rotated_rectangle() |> sf::st_cast("POINT")
    landscape$first_axis[row] <- sf::st_distance(points[1,], points[2,])
    landscape$second_axis[row] <- sf::st_distance(points[2,], points[3,])
  }

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  axes = landscape[c("first_axis", "second_axis")] |> sf::st_drop_geometry()
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "main_axes",
    major = as.double(apply(axes, 1, max)),
    minor = as.double(apply(axes, 1, min))
  )
}
