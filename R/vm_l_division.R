#' @title Landscape division index (vector data)
#'
#' @description Calculate the division index for the entire landscape, reflecting
#' the probability that two randomly selected points are not in the same patch.
#'
#' @details
#' Calculated as: \deqn{DIVISION = 1 - \sum (A_i / A_{landscape})^2}
#' Range: 0 to 1 (unitless). Higher values indicate more fragmentation.
#'
#' @param landscape the input landscape
#' @return A tibble with division index value (0-1)
#' @examples
#' vm_l_division(vector_landscape)
#' @export

vm_l_division <- function(landscape){
  area <- vm_p_area(landscape)
  area_sum <- sum(area$value)
  area$division_p <- (area$value / area_sum) ^ 2
  division_l <- sum(area$division_p)
  division <- 1 - division_l

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "division",
    value = as.double(division)
  ))
}
