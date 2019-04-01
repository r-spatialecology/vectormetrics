#' @title The standard deviation of Ratios between the patch area
#' and the smallest circumscribing circle of patches at class level(vector data)
#' @description This function allows you to calculate the standard deviation of ratios of each class in a categorical landscape in vector data format
#' the ratio is the patch area relative to area of the smallest circumscribing circle of the patch
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of ratios of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_circle_sd(landscape, "landcover")

#' @export
vm_c_circle_sd <- function(landscape, class){
  circle <- vm_p_circle(landscape, class)
  # grouped by the class, and then calculate the standard deviation of core area index in each class.
  circle_sd <- stats::aggregate(circle$value, by= list(circle$class), sd)
  names(circle_sd) <- c("class", "circle_sd")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(circle_sd$class),
    id = as.integer(NA),
    metric = "circle_sd",
    value = as.double(circle_sd$circle_sd)
  )
}
