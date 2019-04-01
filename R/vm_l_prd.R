#' @title Patch richness density (vector data)
#'
#' @description This function allows you to calculate the Patch richness density
#' in a categorical landscape in vector data format, Patch richness density is diversity index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_prd(vector_landscape, "class")

#' @export
vm_l_prd <- function(landscape, class){
  area <- vm_c_ca(landscape, class)
  class_num <- length(area$class)
  A <- sum(area$value * 10000)
  prd <- class_num / A * 10000 * 100
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "prd",
    value = as.double(prd)
  )
}
