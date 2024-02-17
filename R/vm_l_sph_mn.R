#' @title Sphercity(vector data)
#'
#' @description Calculate sphercity
#' @details ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_sph_mn(vector_landscape, "class")
#' @export

vm_l_sph_mn <- function(landscape, class){
  sph <- vm_p_sph(landscape, class)
  sph_l <- mean(sph$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "sph_mn",
    value = as.double(sph_l)
  ))
}
