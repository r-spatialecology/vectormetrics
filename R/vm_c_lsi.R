#' @title Landscape shape index (vector data)

#' @description This function allows you to calculate the ratio between the actual edge length of class i
#' and the hypothetical minimum edge length of class i in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if class i would be maximally aggregated
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_lsi(vector_landscape, "class")

#' @export
vm_c_lsi <- function(landscape, class){
  peri <- vm_p_perim(landscape, class)
  peri_class <- stats::aggregate(peri$value, by= list(peri$class), sum)
  names(peri_class) <- c("class", "peri_class")
  # minimum edge length, is the total perimeter of a circle with the same area of this class
  area <- vm_p_area(landscape, class)
  area$value <- area$value * 10000
  area_c <- stats::aggregate(area$value, by= list(area$class), sum)
  names(area_c) <- c("class", "area_class")
  area_c$R <- sqrt(area_c$area_class/pi)
  area_c$mini <- 2*pi*area_c$R
  lsi <- peri_class$peri_class/area_c$mini

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_c$class),
    id = as.integer(NA),
    metric = "lsi",
    value = as.double(lsi)
  )
}
