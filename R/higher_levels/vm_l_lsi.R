#' @title Landscape shape index (vector data)

#' @description This function allows you to calculate the ratio between the actual edge length of class i
#' and the hypothetical minimum edge length in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if class i would be maximally aggregated
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_lsi(vector_landscape, "class")

#' @export
vm_l_lsi <- function(landscape, class){
  peri <- vm_p_perim(landscape, class)
  peri_landscape <- sum(peri$value)

  # minimum edge length, is the total perimeter of a circle with the same area of this class
  area <- vm_p_area(landscape, class)
  area$value <- area$value * 10000
  area_c <- sum(area$value)

  R <- sqrt(area_c / pi)
  mini <- 2*pi*R
  lsi <- peri_landscape / mini
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "lsi",
    value = as.double(lsi)
  )
}
