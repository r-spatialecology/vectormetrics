#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @details ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' @param landscape the input landscape image,
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_proxim_mn(vector_landscape, n = 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_proxim_mn <- function(landscape, n = 1000){
  proxim <- vm_p_proxim(landscape, n = n)
  proxim_l <- mean(proxim$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "proxim_mn",
    value = as.double(proxim_l)
  ))
}
