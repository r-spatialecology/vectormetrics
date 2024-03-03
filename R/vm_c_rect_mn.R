#' @title Rectangularity(vector data)
#'
#' @description Calculate rectangularity
#' @details ratio between area of shape and its minimum area bounding rectangle (MABR)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_rect_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_c_rect_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the rectangularity for all patches
  rect_idx <- vm_p_rect(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  rect_mn <- stats::aggregate(rect_idx$value, by = list(rect_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(rect_mn)),
    class = as.character(rect_mn[, 1]),
    id = as.character(NA),
    metric = rep("rect_mn", nrow(rect_mn)),
    value = as.double(rect_mn[, 2])
  ))
}
