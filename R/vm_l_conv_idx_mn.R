#' @title Convexity(vector data)
#'
#' @description Calculate convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of convex hull and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_conv_idx(vector_landscape, "class")
#' @export

vm_l_conv_idx_mn <- function(landscape, class){
  conv <- vm_p_conv_idx(landscape, class)
  conv_l <- mean(conv$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "conv_mn",
    value = as.double(conv_l)
  )
}
