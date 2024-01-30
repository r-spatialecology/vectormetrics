#' @title Perimeter-Area ratio.
#'
#' @description This function allows you to calculate the ratio between the patch area and perimeter.
#' The ratio describes the patch complexity in a straightforward way.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_perarea_mn(vector_landscape, "class")
#' @export

vm_c_perarea_mn <- function(landscape, class){
  # calculate the detour index for all patches
  para_idx <- vm_p_perarea(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  para_mn <- stats::aggregate(para_idx$value, by = list(para_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(para_mn)),
    class = as.integer(para_mn[, 1]),
    id = as.integer(NA),
    metric = rep("para_mn", nrow(para_mn)),
    value = as.double(para_mn[, 2])
  ))
}
