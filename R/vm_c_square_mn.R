#' @title Squareness(vector data)
#'
#' @description Calculate squareness
#' @details ratio between perimeter of equal-area square of shape and perimeter of shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_square_mn(vector_landscape, "class")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_c_square_mn <- function(landscape, class){
  # calculate the detour index for all patches
  sq_idx <- vm_p_square(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  sq_mn <- stats::aggregate(sq_idx$value, by = list(sq_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(sq_mn)),
    class = as.integer(sq_mn[, 1]),
    id = as.integer(NA),
    metric = rep("sq_mn", nrow(sq_mn)),
    value = as.double(sq_mn[, 2])
  ))
}
