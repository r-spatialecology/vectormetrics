#' @title Rectangularity(vector data)
#'
#' @description Calculate rectangularity
#' @details ratio between area of shape and its minimum area bounding rectangle (MABR)
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_rect(vector_patches, "class", "patch")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_p_rect <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class_col, patch_col)$value * 10000

  # calculate the area of MABR
  mabr <- geos::geos_minimum_rotated_rectangle(landscape) |> sf::st_as_sf()
  mabr[, class_col] <- landscape[, class_col, drop = TRUE]
  landscape$mabr_area <- vm_p_area(mabr, class_col)$value * 10000

  # ratio of area of polygon and its MABR
  rect_index <- landscape$area / landscape$mabr_area

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("rect_index", nrow(landscape)),
    value = as.double(rect_index)
  ))
}
