#' @title Landscape division index of the whole landscape(vector data)
#'
#' @description This function allows you to calculate the Landscape division index
#' in a categorical landscape in vector data format, Landscape division index can somehow reflect
#' the probability that two randomly selected points are not located in the same patch
#' @param landscape the input landscape image
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
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
