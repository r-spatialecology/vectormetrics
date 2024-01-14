#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_proxim_idx(vector_landscape, "class")
#' @export

vm_c_proxim_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  proxim_idx <- vm_p_proxim_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  proxim_mn <- stats::aggregate(proxim_idx$value, by = list(proxim_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(proxim_mn)),
    class = as.integer(proxim_mn[, 1]),
    id = as.integer(NA),
    metric = rep("proxim_mn", nrow(proxim_mn)),
    value = as.double(proxim_mn[, 2])
  ))
}
