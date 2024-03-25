#' @title Perimeter Index(vector data)
#'
#' @description Calculate Perimeter Index
#' @details ratio between perimeter of equal-area circle and perimeter of polygon
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_perim_idx_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_perim_idx_mn <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the perimeter index for all patches
  perim_idx <- vm_p_perim_idx(landscape, class_col)

  # grouped by the class, and then calculate the average value of detour index for each class,
  perim_mn <- stats::aggregate(perim_idx$value, by = list(perim_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(perim_mn)),
    class = as.character(perim_mn[, 1]),
    id = as.character(NA),
    metric = rep("perim_mn", nrow(perim_mn)),
    value = as.double(perim_mn[, 2])
  ))
}
