#' @title The coefficient of variation of Shape index of each class (vector data)
#' 
#' @description This function allows you to calculate the coefficient of variation
#' of shape index of all patches belonging to one class in a categorical landscape in vector data format
#' shape index is the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_shape_cv(vector_landscape, "class")
#' @export

vm_c_shape_cv <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  shape <- vm_p_shape(landscape, class)
  shape_cv <- stats::aggregate(shape$value, by = list(shape$class), vm_cv)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(shape_cv)),
    class = as.character(shape_cv[, 1]),
    id = as.character(NA),
    metric = rep("shape_cv", nrow(shape_cv)),
    value = as.double(shape_cv[, 2])
  ))
}
