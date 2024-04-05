#' @title Get major and minor axis
#'
#' @description Get major axis (longest line between vertices) and minor axis (longest line inside a shape that is perpendicular to major axis) of polygon
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return sf object with exploded polygons
#' @examples
#' get_axes(vector_landscape, "class")
#' @name get_axes
#' @export

get_axes <- function(landscape, class_col = NULL, patch_col = NULL){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]
  landscape$major_axis <- NA
  landscape$minor_axis <- NA

  for (row in seq_len(nrow(landscape))) {
    tryCatch({
      coords <- landscape[row, ] |> sf::st_coordinates()
      elipsoid <- coords[, 1:2] |> cluster::ellipsoidhull()
      el_pts <- stats::predict(elipsoid)
      distances <- stats::dist(rbind(t(elipsoid$loc), el_pts)) |> as.matrix()
      distances <- distances[1,]
      distances[distances == 0] <- NA
      landscape$major_axis[row] <- round(max(distances, na.rm = TRUE), 2)
      landscape$minor_axis[row] <- round(min(distances, na.rm = TRUE), 2)
    }, error = function(e) {
      landscape$major_axis[row] <- NA
      landscape$minor_axis[row] <- NA
    })
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("main_axes", nrow(landscape)),
    major = landscape$major_axis * 2,
    minor = landscape$minor_axis * 2
  ))
}
