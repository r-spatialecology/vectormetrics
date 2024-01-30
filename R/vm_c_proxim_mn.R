#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @details ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' vm_c_proxim_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_proxim_mn <- function(landscape, class, n = 1000){
  # calculate the detour index for all patches
  proxim_idx <- vm_p_proxim(landscape, class)

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
