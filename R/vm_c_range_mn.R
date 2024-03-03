#' @title Range Index(vector data)
#'
#' @description Calculate Range Index
#' @details ratio between diameter of equal-area circle and diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_range_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_range_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the range index for all patches
  range_idx <- vm_p_range(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  range_mn <- stats::aggregate(range_idx$value, by = list(range_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(range_mn)),
    class = as.character(range_mn[, 1]),
    id = as.character(NA),
    metric = rep("range_mn", nrow(range_mn)),
    value = as.double(range_mn[, 2])
  ))
}
