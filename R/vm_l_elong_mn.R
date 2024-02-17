#' @title Elongation(vector data)
#'
#' @description Calculate elongation of shape
#' @details ratio between major and minor axis length
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_elong_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_l_elong_mn <- function(landscape, class){
  elong <- vm_p_elong(landscape, class)
  elong_l <- mean(elong$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "elong_mn",
    value = as.double(elong_l)
  ))
}
