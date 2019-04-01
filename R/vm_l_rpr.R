#' @title Relative patch richness (vector data)
#'
#' @description This function allows you to calculate the Relative patch richness
#' in a categorical landscape in vector data format, Relative patch richness is diversity index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param class_max the maximal number of class in your input landscape image
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_rpr(vector_landscape, "class")

#' @export
vm_l_rpr <- function(landscape, class, class_max){
  area <- vm_c_ca(landscape, class)
  class_num <- length(area$class)
  rpr <- class_num / class_max * 100
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "rpr",
    value = as.double(rpr)
  )
}
