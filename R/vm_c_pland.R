#' @title Percentage of landscape of class(vector data)
#' @description This function allows you to calculate the percentage of each class in a categorical landscape in vector data format
#' That means each class area is standardised by the total landscape area, so the comparision among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated percentage of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_pland(landscape, "landcover")

#' @export
vm_c_pland <- function(landscape, class){
  # the total landscape area
  area <- vm_p_area(landscape, class)
  A <- sum(area$value) * 10000
  # the area of each class
  area_c <- stats::aggregate(area$value, by= list(area$class), sum)
  names(area_c) <- c("class", "area_class")
  area_c$area_class <- area_c$area_class * 10000

  area_c$pland <- area_c$area_class / A * 100

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_c$class),
    id = as.integer(NA),
    metric = "pland",
    value = as.double(area_c$pland)
  )
}
