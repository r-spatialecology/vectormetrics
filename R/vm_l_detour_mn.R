#' @title Detour Index(vector data)
#'
#' @description Calculate Detour Index
#' @details ratio between perimeter of equal-area circle and perimeter of convex hull of polygon
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_detour_mn(vector_landscape)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_detour_mn <- function(landscape){
  detour <- vm_p_detour(landscape)
  detour_l <- mean(detour$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "detour_mn",
    value = as.double(detour_l)
  ))
}
