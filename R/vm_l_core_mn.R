#' @title The mean value of all core areas in landscape(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of all core patch areas in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of core area of the whole landscape is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_core_mn(vector_landscape, "class", edge_depth= 1)
#' @export

vm_l_core_mn <- function(landscape, class, edge_depth){
  core <- vm_p_core(landscape, class, edge_depth)
  core_l <- mean(core$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "core_mn",
    value = as.double(core_l)
  ))
}
