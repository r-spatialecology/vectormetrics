#' @title Squareness(vector data)
#'
#' @description Calculate squareness
#' @details ratio between perimeter of equal-area square of shape and perimeter of shape
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_square_mn(vector_landscape)
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_l_square_mn <- function(landscape){
  sq <- vm_p_square(landscape)
  sq_l <- mean(sq$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "square_mn",
    value = as.double(sq_l)
  ))
}
