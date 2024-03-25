#' @title Splitting index (vector data)
#' 
#' @description This function allows you to calculate the relation between square of landscape area
#' and sum of square of all patch area of class i in a categorical landscape in vector data format
#' it is a aggregation metric.
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated indices are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_split(vector_landscape, "class")
#' @export

vm_c_split <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  area <- vm_p_area(landscape, class_col)
  area$value <- area$value * 10000
  A <- sum(area$value)

  area$square <- area$value ^2
  area_c <- stats::aggregate(area$square, by = list(area$class), sum, na.rm = FALSE)
  area_c$split <- A^2 / area_c[, 2]

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_c)),
    class = as.character(area_c[, 1]),
    id = as.character(NA),
    metric = rep("split", nrow(area_c)),
    value = as.double(area_c$split)
  ))
}
