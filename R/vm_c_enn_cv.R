#' @title The coefficient of variation of Euclidean Nearest-Neighbor Distance of all patches at class level(vector data)
#' 
#' @description This function allows you to calculate the coefficient of variation
#' of the Euclidean Nearest-Neighbor Distance among patches of one class in a categorical landscape in vector data format
#' Euclidean Nearest-Neighbor Distance means the distance from a patch edge to the nearest neighbouring patch belonging to the
#' same class.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_enn_cv(vector_landscape, "class")
#' @export

vm_c_enn_cv <- function(landscape, class){
  enn <- vm_p_enn(landscape, class)
  enn_cv <- stats::aggregate(enn$value, by = list(enn$class), vm_cv)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(enn_cv)),
    class = as.integer(enn_cv[, 1]),
    id = as.integer(NA),
    metric = rep("enn_cv", nrow(enn_cv)),
    value = as.double(enn_cv[, 2])
  ))
}
