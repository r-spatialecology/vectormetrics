#' @title The coefficient of variation of each class core areas(vector data)
#' 
#' @description This function allows you to calculate the coefficient of variation
#' of all patch core areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated coefficient of variation of core areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_core_cv(vector_landscape, "class", edge_depth = 1)
#' @export

vm_c_core_cv <- function(landscape, class, edge_depth){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  core <- vm_p_core(landscape, class, edge_depth = edge_depth)
  core_cv <- stats::aggregate(core$value, by = list(core$class), vm_cv)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(core_cv)),
    class = as.character(core_cv[, 1]),
    id = as.character(NA),
    metric = rep("core_cv", nrow(core_cv)),
    value = as.double(core_cv[, 2])
  ))
}
