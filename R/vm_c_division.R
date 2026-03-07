#' @title Landscape division index of each class (vector data)
#'
#' @description Calculate the division index for each class, reflecting the probability
#' that two randomly selected points are not in the same patch.
#'
#' @details
#' Calculated as: \deqn{DIVISION = 1 - \sum (A_i / A_{landscape})^2}
#' Range: 0 to 1 (unitless). Higher values indicate more fragmentation.
#'
#' @param landscape the input landscape
#' @param class_col the name of the class column
#' @return A tibble with division index values (0-1)
#' @examples
#' vm_c_division(vector_landscape, "class")
#' @export

vm_c_division <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  area <- vm_p_area(landscape, class_col)
  area_sum <- sum(area$value)
  area$division <- (area$value / area_sum)^2

  c_division <- stats::aggregate(area$division, list(area$class), sum)
  c_division$division <- 1 - c_division[, 2]

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(c_division)),
    class = as.character(c_division[, 1]),
    id = as.character(NA),
    metric = rep("division", nrow(c_division)),
    value = as.double(c_division$division)
  ))
}
