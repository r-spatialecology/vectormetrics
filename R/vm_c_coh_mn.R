#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @details ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_coh_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles. 
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_coh_mn <- function(landscape, class, n = 1000){
  # calculate the detour index for all patches
  coh_idx <- vm_p_coh(landscape, class, n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  coh_mn <- stats::aggregate(coh_idx$value, by = list(coh_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(coh_mn)),
    class = as.integer(coh_mn[, 1]),
    id = as.integer(NA),
    metric = rep("coh_mn", nrow(coh_mn)),
    value = as.double(coh_mn[, 2])
  ))
}
