#' @title fractal dimension index(vector data)
#'
#' @description This function allows you to calculate index fractal dimension index.
#' The index is based on the patch perimeter and the patch area and describes the patch complexity.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_frac_mn(vector_landscape, "class")
#' @export

vm_c_frac_mn <- function(landscape, class){
  # calculate the detour index for all patches
  frac <- vm_p_frac(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  frac_mn <- stats::aggregate(frac$value, by = list(frac$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(frac_mn)),
    class = as.integer(frac_mn[, 1]),
    id = as.integer(NA),
    metric = rep("frac_mn", nrow(frac_mn)),
    value = as.double(frac_mn[, 2])
  ))
}
