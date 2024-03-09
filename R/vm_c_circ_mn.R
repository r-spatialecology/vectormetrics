#' @title Circularity(vector data)
#'
#' @description Calculate Circularity
#' @details ratio between area of polygon and area of equal-perimeter circle
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_circ_mn(vector_landscape, "class")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_c_circ_mn <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the detour index for all patches
  circ_idx <- vm_p_circ(landscape, class_col)

  # grouped by the class, and then calculate the average value of detour index for each class,
  circ_mn <- stats::aggregate(circ_idx$value, by = list(circ_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(circ_mn)),
    class = as.character(circ_mn[, 1]),
    id = as.character(NA),
    metric = rep("circ_mn", nrow(circ_mn)),
    value = as.double(circ_mn[, 2])
  ))
}
