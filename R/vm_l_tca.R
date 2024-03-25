#' @title The total core area of the whole landscape(vector data)
#' 
#' @description This function allows you to calculate the total core area
#' in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated total class core areas are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_tca(vector_landscape, edge_depth= 1)
#' @export

vm_l_tca <- function(landscape, edge_depth){
  core <- vm_p_core(landscape, edge_depth = edge_depth)
  core_sum <- sum(core$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "tca",
    value = as.double(core_sum)
  ))
}
