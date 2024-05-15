#' @title Area of the convex hull(vector data)
#'
#' @description Calculate area of the convex hull of the polygon
#' @details area of the convex hull of the polygon
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' get_hull_area(vector_patches, "class", "patch")
#' @export

get_hull_area <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if (!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))) {
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")) {
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  convex <- sf::st_convex_hull(landscape)
  convex_area <- vm_p_area(convex, class_col, patch_col)$value * 10000

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("convex_area", nrow(landscape)),
    value = as.double(convex_area)
  ))
}
