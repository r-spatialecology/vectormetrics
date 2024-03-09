#' @title The mean value of core area index at class level(vector data)
#'
#' @description This function allows you to calculate the mean value
#' of ratio of the core area and the area belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of core area index of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_cai_mn(vector_landscape, "class", edge_depth = 1)
#' @export

vm_c_cai_mn <- function(landscape, class_col, edge_depth){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())
  
  cai <- vm_p_cai(landscape, class_col, edge_depth = edge_depth)
  cai_mn <- stats::aggregate(cai$value, by = list(cai$class), mean, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(cai_mn)),
    class = as.character(cai_mn[, 1]),
    id = as.character(NA),
    metric = rep("cai_mn", nrow(cai_mn)),
    value = as.double(cai_mn[, 2])
  ))
}
