#' @title Sphercity(vector data)
#'
#' @description Calculate sphercity
#' @details ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_sph_mn(vector_landscape)
#' @export

vm_l_sph_mn <- function(landscape){
  sph <- vm_p_sph(landscape)
  sph_l <- mean(sph$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "sph_mn",
    value = as.double(sph_l)
  ))
}
