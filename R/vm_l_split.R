#' @title Splitting index (vector data)
#' 
#' @description This function allows you to calculate the relation between square of landscape area
#' and sum of square of all patch area in a categorical landscape in vector data format
#' it is a aggregation metric.
#' @param landscape the input landscape image,
#' @return  the returned calculated indices are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_split(vector_landscape)
#' @export

vm_l_split <- function(landscape){
  # the total landscape area in square meters
  area <- vm_p_area(landscape)
  area$value <- area$value * 10000
  A <- sum(area$value)
  # the sum of all the area squares of patches
  area$square <- area$value ^2
  split <- A^2 / sum(area$square)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "split",
    value = as.double(split)
  ))
}
