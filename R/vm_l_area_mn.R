#' @title The mean value of all patch areas at landscape level(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of all patch areas in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @return  the returned calculated mean value of areas is in column "value",
#' and this function returns also some important information such as level and metric name,
#' @examples
#' vm_l_area_mn(vector_landscape)
#' @export

vm_l_area_mn <- function(landscape){
  area <- vm_p_area(landscape)
  area_l <- mean(area$value * 10000)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "area_mn",
    value = as.double(area_l)
  ))
}
