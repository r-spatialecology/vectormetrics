#' @title Elongation(vector data)
#'
#' @description Calculate elongation of shape
#' @details ratio between major and minor axis length
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_elong_mn(vector_landscape, "class")
#' @references 
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_c_elong_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the elongation for all patches
  elong_idx <- vm_p_elong(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  elong_mn <- stats::aggregate(elong_idx$value, by = list(elong_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(elong_mn)),
    class = as.character(elong_mn[, 1]),
    id = as.character(NA),
    metric = rep("elong_mn", nrow(elong_mn)),
    value = as.double(elong_mn[, 2])
  ))
}
