#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between radius of maximum inscribed circle and radius of equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_girth_idx(vector_landscape, "class")
#' @export

vm_l_girth_idx_mn <- function(landscape, class){
  girth <- vm_p_girth_idx(landscape, class)
  girth_l <- mean(girth$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "girth_mn",
    value = as.double(girth_l)
  )
}
