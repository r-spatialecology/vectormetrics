#' @title Convexity(vector data)
#'
#' @description Calculate convexity
#' @details ratio between perimeter of convex hull and perimeter of polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_convex_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_l_convex_mn <- function(landscape, class){
  conv <- vm_p_convex(landscape, class)
  conv_l <- mean(conv$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "conv_mn",
    value = as.double(conv_l)
  ))
}
