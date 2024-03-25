#' @title Roughness index(vector data)
#'
#' @description Calculate Roughness index (RI)
#' @details to be added...
#' @param landscape the input landscape image,
#' @param n number of boundary points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_rough_mn(vector_landscape, n = 100)
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_l_rough_mn <- function(landscape, n = 100){
  ri <- vm_p_rough(landscape, n = n)
  ri_l <- mean(ri$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "ri_mn",
    value = as.double(ri_l)
  ))
}
