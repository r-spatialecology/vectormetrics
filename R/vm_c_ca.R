#' @title The total area of each class(vector data)

#' @description This function allows you to calculate the total area
#' of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated total class areas are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_ca(vector_landscape, "class")

#' @export
vm_c_ca <- function(landscape, class){

  area <- vm_p_area(landscape, class)

  area_sum <- stats::aggregate(area$value, by= list(area$class), sum, na.rm = TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_sum[, 1]),
    id = as.integer(NA),
    metric = "ca",
    value = as.double(area_sum[, 2])
  )
}
