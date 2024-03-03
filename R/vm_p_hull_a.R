#' @title Area of the convex hull(vector data)
#'
#' @description Calculate area of the convex hull of the polygon
#' @details area of the convex hull of the polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_hull_a(vector_patches, "class", "patch")
#' @export

vm_p_hull_a <- function(landscape, class = NA, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if (!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))) {
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")) {
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  convex <- sf::st_convex_hull(landscape)
  convex_area <- vm_p_area(convex, class, patch_id)$value * 10000

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("convex_area", nrow(landscape)),
    value = as.double(convex_area)
  ))
}
