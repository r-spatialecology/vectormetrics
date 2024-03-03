#' @title the number of disjunct core area in the whole landscape(vector data)
#' 
#' @description This function allows you to calculate the number of disjunct core areas in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated number of core area is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_ndca(vector_landscape, edge_depth = 1)
#' @export

vm_l_ndca <- function(landscape, edge_depth){
  dcore <- vm_p_ncore(landscape, edge_depth = edge_depth)
  dcore_l <- sum(dcore$value)
  
  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "ndca",
    value = as.double(dcore_l)
  ))
}
