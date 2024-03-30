#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @details ratio between the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_fullness_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_fullness_mn <- function(landscape, class_col, n = 1000){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the fullness index for all patches
  full_idx <- vm_p_fullness(landscape, class_col, n = n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  full_mn <- stats::aggregate(full_idx$value, by = list(full_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(full_mn)),
    class = as.character(full_mn[, 1]),
    id = as.character(NA),
    metric = rep("full_mn", nrow(full_mn)),
    value = as.double(full_mn[, 2])
  ))
}
