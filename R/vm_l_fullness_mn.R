#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @details ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' @param landscape the input landscape image,
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_fullness_mn(vector_landscape, n = 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_fullness_mn <- function(landscape, n = 1000){
  full <- vm_p_fullness(landscape, n = n)
  full_l <- mean(full$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "full_mn",
    value = as.double(full_l)
  ))
}
