#' @title Solidity(vector data)
#'
#' @description Solidity convexity
#' @details ratio between area of convex hull and area of polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_solid_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_l_solid_mn <- function(landscape, class){
  solid <- vm_p_solid(landscape, class)
  solid_l <- mean(solid$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "solid_mn",
    value = as.double(solid_l)
  ))
}
