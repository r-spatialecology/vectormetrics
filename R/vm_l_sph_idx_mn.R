#' @title Sphrecity(vector data)
#'
#' @description Calculate sphercity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sph_idx(vector_landscape, "class")
#' @export

vm_l_sph_idx_mn <- function(landscape, class){
  sph <- vm_p_sph_idx(landscape, class)
  sph_l <- mean(sph$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "sph_mn",
    value = as.double(sph_l)
  ))
}
