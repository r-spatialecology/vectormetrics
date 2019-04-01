#' @title The mean value of the fractal dimension index of all patches in each class(vector data)
#' @description This function allows you to calculate the mean value
#' of fractal dimension index of all patches belonging to class i in a categorical landscape in vector data format
#' The index is based on the patch perimeter and the patch area and describes the patch complexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated mean value of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.

#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_frac_mn(landscape, "landcover")

#' @export
vm_c_frac_mn <- function(landscape, class){
  frac <- vm_p_frac(landscape, class)
  # grouped by the class, and then calculate the mean value of fractal dimension index in each class.
  frac_mn <- stats::aggregate(frac$value, by= list(frac$class), mean)
  names(frac_mn) <- c("class", "frac_mn")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(frac_mn$class),
    id = as.integer(NA),
    metric = "frac_mn",
    value = as.double(frac_mn$frac_mn)
  )
}
