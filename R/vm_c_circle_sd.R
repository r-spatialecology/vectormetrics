#' @title The standard deviation of Ratios between the patch area
#' and the smallest circumscribing circle of patches at class level(vector data)
#' 
#' @description This function allows you to calculate the standard deviation of ratios of each class in a categorical landscape in vector data format
#' the ratio is the patch area relative to area of the smallest circumscribing circle of the patch
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of ratios of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_circle_sd(vector_landscape, "class")
#' @export

vm_c_circle_sd <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  circle <- vm_p_circle(landscape, class_col)
  circle_sd <- stats::aggregate(circle$value, by = list(circle$class), stats::sd, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(circle_sd)),
    class = as.character(circle_sd[, 1]),
    id = as.character(NA),
    metric = rep("circle_sd", nrow(circle_sd)),
    value = as.double(circle_sd[, 2])
  ))
}
