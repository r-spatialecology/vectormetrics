#' @title Detour Index(vector data)
#'
#' @description Calculate Detour Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of convex hull of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_detour_idx_mn(vector_landscape, "class")
#' @export

vm_l_detour_idx_mn <- function(landscape, class){
  detour <- vm_p_detour_idx(landscape, class)
  detour_l <- mean(detour$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "detour_mn",
    value = as.double(detour_l)
  )
}
