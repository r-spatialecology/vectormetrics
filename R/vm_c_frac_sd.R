#' @title The standard deviation of the fractal dimension index of all patches in each class(vector data)
#' 
#' @description This function allows you to calculate the standard deviation
#' of fractal dimension index of all patches belonging to class i in a categorical landscape in vector data format
#' The index is based on the patch perimeter and the patch area and describes the patch complexity
#' @param landscape the input landscape image, should in "POLYGON" or "MULTIPOLYGON" form.
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_frac_sd(vector_landscape, "class")
#' @export

vm_c_frac_sd <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  frac <- vm_p_frac(landscape, class_col)
  frac_sd <- stats::aggregate(frac$value, by = list(frac$class), stats::sd, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(frac_sd)),
    class = as.character(frac_sd[, 1]),
    id = as.character(NA),
    metric = rep("frac_sd", nrow(frac_sd)),
    value = as.double(frac_sd[, 2])
  ))
}
