#' @title Largest patch index(vector data)

#' @description This function allows you to calculate the maximal patch area of each class in relative to
#' total landscape area in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_lpi(vector_landscape, "class")

#' @export
vm_c_lpi <- function(landscape, class){

  area <- vm_p_area(landscape, class)

  sum_landscape <- sum(area$value) * 10000

  area_max <- stats::aggregate(area$value,
                               by= list(area$class),
                               max,
                               na.rm = TRUE)

  area_max$lpi <- area_max[, 2]*10000/sum_landscape * 100

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_max[, 1]),
    id = as.integer(NA),
    metric = "lpi",
    value = as.double(area_max[, 2])
  )
}
