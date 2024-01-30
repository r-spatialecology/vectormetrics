#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @details ratio between radius of maximum inscribed circle and radius of equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_girth_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_girth_mn <- function(landscape, class){
  # calculate the detour index for all patches
  girth_idx <- vm_p_girth(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  girth_mn <- stats::aggregate(girth_idx$value, by = list(girth_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(girth_mn)),
    class = as.integer(girth_mn[, 1]),
    id = as.integer(NA),
    metric = rep("girth_mn", nrow(girth_mn)),
    value = as.double(girth_mn[, 2])
  ))
}
