#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @details ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' @param landscape the input landscape image,
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_coh_mn(vector_landscape, n = 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles. 
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_coh_mn <- function(landscape, n = 1000){
  coh <- vm_p_coh(landscape, n = n)
  coh_l <- mean(coh$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "coh_mn",
    value = as.double(coh_l)
  ))
}
