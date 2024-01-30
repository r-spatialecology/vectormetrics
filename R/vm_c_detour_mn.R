#' @title Detour Index(vector data)
#'
#' @description Calculate Detour Index
#' @details ratio between perimeter of equal-area circle and perimeter of convex hull of polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_detour_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_detour_mn <- function(landscape, class){
  # calculate the detour index for all patches
  detour_idx <- vm_p_detour(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  detour_mn <- stats::aggregate(detour_idx$value, by = list(detour_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(detour_mn)),
    class = as.integer(detour_mn[, 1]),
    id = as.integer(NA),
    metric = rep("detour_mn", nrow(detour_mn)),
    value = as.double(detour_mn[, 2])
  ))
}
