#' @title Landscape shape index (vector data)
#' 
#' @description This function allows you to calculate the ratio between the actual edge length of class i
#' and the hypothetical minimum edge length in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if class i would be maximally aggregated
#' @param landscape the input landscape image,
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' vm_l_lsi(vector_landscape)
#' @export

vm_l_lsi <- function(landscape){
  peri <- vm_p_perim(landscape)
  peri_landscape <- sum(peri$value)

  # minimum edge length, is the total perimeter of a circle with the same area of this class
  area <- vm_p_area(landscape)
  area$value <- area$value * 10000
  area_c <- sum(area$value)

  R <- sqrt(area_c / pi)
  mini <- 2 * pi * R
  lsi <- peri_landscape / mini

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "lsi",
    value = as.double(lsi)
  ))
}
