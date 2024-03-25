#' @title Roughness index(vector data)
#'
#' @description Calculate Roughness index (RI)
#' @details to be added...
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param n number of boundary points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_rough_mn(vector_landscape, "class")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_c_rough_mn <- function(landscape, class_col, n = 100){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the roughness for all patches
  ri <- vm_p_rough(landscape, class_col, n = n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  ri_mn <- stats::aggregate(ri$value, by = list(ri$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(ri_mn)),
    class = as.character(ri_mn[, 1]),
    id = as.character(NA),
    metric = rep("rough_mn", nrow(ri_mn)),
    value = as.double(ri_mn[, 2])
  ))
}
