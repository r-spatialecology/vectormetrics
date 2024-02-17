#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @details share of the total area of the shape that is inside the equal-area circle about its centroid
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_exchange_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_exchange_mn <- function(landscape, class){
  exchange <- vm_p_exchange(landscape, class)
  exchange_l <- mean(exchange$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "exchange_mn",
    value = as.double(exchange_l)
  ))
}
