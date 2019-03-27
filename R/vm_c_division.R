#' @title Landscape division index of each class(vector data)
#'
#' @description This function allows you to calculate the Landscape division index
#' of each class in a categorical landscape in vector data format, Landscape division index can somehow reflect
#' the probability that two randomly selected points are not located in the same patch of class i
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_division(landscape, "landcover")

#' @export
vm_c_division <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  area_sum <- sum(area$value)
  area$division <- (area$value/area_sum)^2
  c_division <- aggregate(area$division, list(area$class), sum)
  names(c_division) <- c("class", "division")
  c_division$division <- 1 - c_division$division

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(c_division$class),
    id = as.integer(NA),
    metric = "division",
    value = as.double(c_division$division)
  )
}
