#' @title The standard deviation of Euclidean Nearest-Neighbor Distance of patches in each class(vector data)
#' 
#' @description This function allows you to calculate the standard deviation
#' of Euclidean Nearest-Neighbor Distance among patches of one class in a categorical landscape in vector data format
#' @param landscape the input landscape image, should in "POLYGON" or "MULTIPOLYGON" form.
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_enn_sd(vector_landscape, "class")
#' @export

vm_c_enn_sd <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  enn <- vm_p_enn(landscape, class)
  enn_sd <- stats::aggregate(enn$value, by = list(enn$class), stats::sd, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(enn_sd)),
    class = as.character(enn_sd[, 1]),
    id = as.character(NA),
    metric = rep("enn_sd", nrow(enn_sd)),
    value = as.double(enn_sd[, 2])
  ))
}
