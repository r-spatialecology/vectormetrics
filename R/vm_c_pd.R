#' @title the patch density in each class(vector data)
#' 
#' @description This metric is based on categorical landscape in vector data format. The density is the number of patches of each class
#' relative to the total landscape area. Then the number is standardised, so that the comparison among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated density of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_pd(vector_landscape, "class")
#' @export

vm_c_pd <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  patch <- vm_c_np(landscape, class_col)
  area <- vm_p_area(landscape, class_col)
  A <- sum(area$value * 10000)
  patch$pd <- patch$value / A * 10000 * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(patch)),
    class = as.character(patch$class),
    id = as.character(NA),
    metric = rep("pd", nrow(patch)),
    value = as.double(patch$pd)
  ))
}
