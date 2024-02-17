#' @title Circularity(vector data)
#' 
#' @description Circularity convexity
#' @details ratio between area of polygon and area of equal-perimeter circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_circ_mn(vector_landscape, "class")
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_l_circ_mn <- function(landscape, class){
  circ <- vm_p_circ(landscape, class)
  circ_l <- mean(circ$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "circ_mn",
    value = as.double(circ_l)
  ))
}
