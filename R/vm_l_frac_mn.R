#' @title The mean value of the fractal dimension index of landscape(vector data)
#' @description This function allows you to calculate the mean value
#' of fractal dimension index in a categorical landscape in vector data format
#' The index is based on the patch perimeter and the patch area and describes the patch complexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated mean value of the whole landscape is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level

#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_frac_mn(vector_landscape, "class")

#' @export
vm_l_frac_mn <- function(landscape, class){
  frac <- vm_p_frac(landscape, class)
  frac_l <- mean(frac$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "frac_mn",
    value = as.double(frac_l)
  )
}
