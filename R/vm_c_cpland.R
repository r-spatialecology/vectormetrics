#' @title Core area percentage of landscape in each class(vector data)
#'
#' @description This function allows you to calculate the total core area of each class
#' in relation to the landscape area in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated ratios are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_cpland(vector_landscape, "class", edge_depth = 1)
#' @export

vm_c_cpland <- function(landscape, class, edge_depth){
  area <- vm_p_area(landscape, class)
  sum_landscape <- sum(area$value)

  core <- vm_p_core(landscape, class, edge_depth)
  core_sum <- stats::aggregate(core$value, by = list(core$class), sum, na.rm = FALSE)

  # calculate the core area percentage of landscape
  core_sum$cpland <- (core_sum[, 2]/sum_landscape) * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(core_sum)),
    class = as.integer(core_sum[, 1]),
    id = as.integer(NA),
    metric = rep("cpland", nrow(core_sum)),
    value = as.double(core_sum$cpland)
  ))
}
