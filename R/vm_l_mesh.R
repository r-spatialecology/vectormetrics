#' @title Effective Mesh Size (vector data)
#' 
#' @description This function helps to analyse the patch structure
#' the calculate process is, each patch is squared before the sums of them are calculated
#' and the sum is standardized by the total landscape area. it is a aggregation metric.
#' @param landscape the input landscape image
#' @return  the returned calculated values are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_mesh(vector_landscape)
#' @export

vm_l_mesh <- function(landscape){
  # calculate the area of all the patches and then square it
  area <- vm_p_area(landscape)
  area$value <- area$value * 10000
  area$value_2 <- (area$value) ^ 2

  area_sum <- sum(area$value_2)
  # calculate the total landscape area
  A <- sum(area$value)
  mesh <- area_sum / A / 10000

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "mesh",
    value = as.double(mesh)
  ))
}
