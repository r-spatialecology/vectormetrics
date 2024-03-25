#' @title The standard deviation of Perimeter-Area ratio index of all patches at class level(vector data)
#' 
#' @description This function allows you to calculate the standard deviation
#' of the ratios of all patches belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_perarea_sd(vector_landscape, "class")
#' @export

vm_c_perarea_sd <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  para <- vm_p_perarea(landscape, class_col)
  para_sd <- stats::aggregate(para$value, by = list(para$class), stats::sd, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(para_sd)),
    class = as.character(para_sd[, 1]),
    id = as.character(NA),
    metric = rep("para_sd", nrow(para_sd)),
    value = as.double(para_sd[, 2])
  ))
}
