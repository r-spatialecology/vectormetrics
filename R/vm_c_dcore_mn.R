#' @title The mean value of number of core areas in each class(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of the total number of disjunct core areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of number of core areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_dcore_mn(vector_landscape, "class", edge_depth = 1)
#' @export

vm_c_dcore_mn <- function(landscape, class_col, edge_depth){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  dcore <- vm_p_ncore(landscape, class_col, edge_depth = edge_depth)
  dcore_mn <- stats::aggregate(dcore$value, by = list(dcore$class), mean, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(dcore_mn)),
    class = as.character(dcore_mn[, 1]),
    id = as.character(NA),
    metric = rep("dcore_mn", nrow(dcore_mn)),
    value = as.double(dcore_mn[, 2])
  ))
}
