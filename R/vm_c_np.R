#' @title the number of patches in each class(vector data)
#' 
#' @description This function allows you to calculate the number of patches of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated number of patches of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_np(vector_landscape, "class")
#' @export

vm_c_np <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  area <- vm_p_area(landscape, class)
  patch <- table(area$class) |> as.data.frame()
  
  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(patch)),
    class = as.character(patch[, 1]),
    id = as.character(NA),
    metric = rep("np", nrow(patch)),
    value = as.integer(patch[, 2])
  ))
}
