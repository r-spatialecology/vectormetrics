#' @title The coefficient of variation of Perimeter-Area ratio index of each class (vector data)
#' 
#' @description This function allows you to calculate the coefficient of variation
#' of the ratios of all patches belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_perarea_cv(vector_landscape, "class")
#' @export

vm_c_perarea_cv <- function(landscape, class){
  para <- vm_p_perarea(landscape, class)
  para_cv <- stats::aggregate(para$value, by = list(para$class), vm_cv)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(para_cv)),
    class = as.integer(para_cv[, 1]),
    id = as.integer(NA),
    metric = rep("para_cv", nrow(para_cv)),
    value = as.double(para_cv[, 2])
  ))
}
