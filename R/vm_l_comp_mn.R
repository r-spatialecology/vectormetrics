#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @details Mean compactness across all patches in the landscape.
#' Compactness is calculated as:
#' \deqn{COMPACT = \frac{4\pi A}{P^2}}
#' where \eqn{A} is the patch area (m²) and \eqn{P} is the perimeter (m).
#' Values range from 0 (linear) to 1 (circular).
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_comp_mn(vector_landscape)
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_l_comp_mn <- function(landscape){
  comp <- vm_p_comp(landscape)
  comp_l <- mean(comp$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "comp_mn",
    value = as.double(comp_l)
  ))
}
