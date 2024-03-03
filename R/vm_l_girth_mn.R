#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @details ratio between radius of maximum inscribed circle and radius of equal-area circle
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_girth_mn(vector_landscape)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_girth_mn <- function(landscape){
  girth <- vm_p_girth(landscape)
  girth_l <- mean(girth$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "girth_mn",
    value = as.double(girth_l)
  ))
}
