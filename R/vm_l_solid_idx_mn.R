#' @title Solidity(vector data)
#'
#' @description Solidity convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of convex hull and area of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_solid_idx(vector_landscape, "class")
#' @export

vm_l_solid_idx_mn <- function(landscape, class){
  solid <- vm_p_solid_idx(landscape, class)
  solid_l <- mean(solid$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "solid_mn",
    value = as.double(solid_l)
  )
}
