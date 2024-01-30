#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @details sqrt(4 * area / pi) / perimeter
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_comp_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_c_comp_mn <- function(landscape, class){
  # calculate the detour index for all patches
  comp_idx <- vm_p_comp(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  comp_mn <- stats::aggregate(comp_idx$value, by = list(comp_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(comp_mn)),
    class = as.integer(comp_mn[, 1]),
    id = as.integer(NA),
    metric = rep("comp_mn", nrow(comp_mn)),
    value = as.double(comp_mn[, 2])
  ))
}
