#' @title Range Index(vector data)
#'
#' @description Calculate Range Index
#' @details ratio between diameter of equal-area circle and diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_range_mn(vector_landscape)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_range_mn <- function(landscape){
  range <- vm_p_range(landscape)
  range_l <- mean(range$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "range_mn",
    value = as.double(range_l)
  ))
}
