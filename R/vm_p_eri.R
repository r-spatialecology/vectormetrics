#' @title Equivalent rectangular index(vector data)
#'
#' @description Calculate Equivalent rectangular index (ERI)
#' @details ratio between perimeter of equal-area rectangle of shape and perimeter of shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_eri(vector_patches, "class", "patch")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_p_eri <- function(landscape, class = NA, patch_id = NA){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  perim <- vm_p_perim(landscape, class, patch_id)$value
  area <- vm_p_area(landscape, class, patch_id)$value * 10000
  mabr_area <- landscape |> sf::st_minimum_rotated_rectangle() |> vm_p_area(class, patch_id)
  mabr_perim <- landscape |> sf::st_minimum_rotated_rectangle() |> vm_p_perim(class, patch_id)

  ear_perim <- sqrt(area / (mabr_area$value * 10000)) * mabr_perim$value
  eri <- ear_perim / perim

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("ERI", nrow(landscape)),
    value = as.double(eri)
  ))
}
