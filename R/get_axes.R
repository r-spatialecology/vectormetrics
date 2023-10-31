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
    coords <- landscape[row, ] |> sf::st_coordinates()
    elipsoid <- coords[, 1:2] |> cluster::ellipsoidhull()
    el_pts <- predict(elipsoid)
    distances <- dist(rbind(t(elipsoid$loc), el_pts)) |> as.matrix()
    distances <- distances[1,]
    distances[distances == 0] <- NA
    landscape$major_axis[row] <- round(max(distances, na.rm = TRUE), 2)
    landscape$minor_axis[row] <- round(min(distances, na.rm = TRUE), 2)
  }

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "main_axes",
    major = landscape$major_axis * 2,
    minor = landscape$minor_axis * 2
  )
}
