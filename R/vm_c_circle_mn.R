#' @title The mean value of Ratios between the patch area
#' and the smallest circumscribing circle of patches at class level(vector data)
#' @description This function allows you to calculate the mean value of ratios of each class in a categorical landscape in vector data format
#' the ratio is the patch area relative to area of the smallest circumscribing circle of the patch
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated mean value of ratios of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_circle_mn(vector_landscape, "class")

#' @export
vm_c_circle_mn <- function(landscape, class) {

  circle <- vm_p_circle(landscape, class)

  circle_mn <- stats::aggregate(circle$value,
                                by = list(circle$class),
                                mean,
                                na.rm =TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(circle_mn[, 1]),
    id = as.integer(NA),
    metric = "circle_mn",
    value = as.double(circle_mn[, 2])
  )

}
