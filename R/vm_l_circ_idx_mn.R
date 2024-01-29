#' @title Circularity(vector data)
#'
#' @description Circularity convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of polygon and area of equal-perimeter circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_circ(vector_landscape, "class")
#' @export

vm_l_circ_idx_mn <- function(landscape, class){
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
