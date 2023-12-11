#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_proxim_idx(vector_landscape, "class")
#' @export

vm_l_proxim_idx_mn <- function(landscape, class){
  proxim <- vm_p_proxim_idx(landscape, class)
  proxim_l <- mean(proxim$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "proxim_mn",
    value = as.double(proxim_l)
  )
}
