#' @title Largest patch index(vector data)

#' @description This function allows you to calculate the maximal patch area in relative to
#' total landscape area in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_lpi(vector_landscape, "class")

#' @export
vm_l_lpi <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  # landscape area
  sum_landscape <- sum(area$value) * 10000
  # maximal patch area of each class
  area_max <- max(area$value)


  lpi <- area_max * 10000 / sum_landscape * 100
  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "lpi",
    value = as.double(lpi)
  ))
}
