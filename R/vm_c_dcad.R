#' @title Disjunct core area density of each class(vector data)
#' 
#' @description This function allows you to calculate the number of disjunct core areas of each class
#' in relation to the landscape area in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated ratios are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_dcad(vector_landscape, "class", edge_depth = 1)
#' @export

vm_c_dcad <- function(landscape, class_col, edge_depth){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # the total landscape area
  area <- vm_p_area(landscape, class_col)
  area$value <- area$value * 10000
  area_sum <- sum(area$value)

  core_num <- vm_p_ncore(landscape, class_col, edge_depth = edge_depth)
  # grouped by the class, and then calculate the sum of number of disjunct core area in each class
  core_num_sum <- stats::aggregate(core_num$value, list(core_num$class), sum)
  core_num_sum$DCAD <- (core_num_sum[, 2] / area_sum) * 10000 * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(core_num_sum)),
    class = as.character(core_num_sum[, 1]),
    id = as.character(NA),
    metric = rep("DCAD", nrow(core_num_sum)),
    value = as.double(core_num_sum$DCAD)
  ))
}
