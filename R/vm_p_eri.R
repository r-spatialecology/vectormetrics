#' @title Equivalent rectangular index(vector data)
#'
#' @description Calculate Equivalent rectangular index (ERI)
#' @details ratio between perimeter of equal-area rectangle of shape and perimeter of shape
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_eri(vector_patches, "class", "patch")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_p_eri <- function(landscape, class_col = NULL, patch_col = NULL){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  perim <- vm_p_perim(landscape, class_col, patch_col)$value
  area <- vm_p_area(landscape, class_col, patch_col)$value * 10000
  mabr <- landscape |> sf::st_minimum_rotated_rectangle()
  mabr_area <- mabr |> vm_p_area(class_col, patch_col)
  mabr_perim <- mabr |> vm_p_perim(class_col, patch_col)

  ear_perim <- sqrt(area / (mabr_area$value * 10000)) * mabr_perim$value
  eri <- ear_perim / perim

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("ERI", nrow(landscape)),
    value = as.double(eri)
  ))
}
