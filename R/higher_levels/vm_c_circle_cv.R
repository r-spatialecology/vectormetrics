#' @title The coefficient of variation of Ratios between the patch area
#' and the smallest circumscribing circle of all patches at class level(vector data)
#' @description This function allows you to calculate the coefficient of variation of ratios of each class in a categorical landscape in vector data format
#' the ratio is the patch area relative to area of the smallest circumscribing circle of the patch
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation in each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_circle_cv(vector_landscape, "class")
#' @export

vm_c_circle_cv <- function(landscape, class){

  circle <- vm_p_circle(landscape, class)

  circle_cv <- stats::aggregate(circle$value, by= list(circle$class), vm_cv)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(circle_cv[, 1]),
    id = as.integer(NA),
    metric = "circle_cv",
    value = as.double(circle_cv[, 2])
  )

}
