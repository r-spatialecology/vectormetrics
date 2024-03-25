#' @title Convexity(vector data)
#'
#' @description Calculate convexity
#' @details ratio between perimeter of convex hull and perimeter of polygon
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_convex(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_p_convex <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if (!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))) {
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")) {
    message("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # calculate the perimeter of polygons
  landscape$perim <- vm_p_perim(landscape, class_col, patch_col)$value

  # calculate the perimeter of convex hull
  landscape$conv_perim <- vm_p_hull_p(landscape, class_col, patch_col)$value

  # ratio of perimeter of convex hull and polygon perimeters
  conv_index <- landscape$conv_perim / landscape$perim

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("conv_index", nrow(landscape)),
    value = as.double(conv_index)
  ))
}
