#' @title Percentage of landscape of class(vector data)
#' 
#' @description This function allows you to calculate the percentage of each class in a categorical landscape in vector data format
#' That means each class area is standardised by the total landscape area, so the comparision among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated percentage of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_pland(vector_landscape, "class")
#' @export

vm_c_pland <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  A <- sum(area$value) * 10000
  area_c <- stats::aggregate(area$value, by = list(area$class), sum, na.rm = FALSE)

  area_c$area_class <- area_c[, 2] * 10000
  area_c$pland <- area_c$area_class / A * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_c)),
    class = as.integer(area_c[, 1]),
    id = as.integer(NA),
    metric = rep("pland", nrow(area_c)),
    value = as.double(area_c$pland)
  ))
}
