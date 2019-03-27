#' @title the patch density in each class(vector data)
#' @description This metric is based on categorical landscape in vector data format. The density is the number of patches of each class
#' relative to the total landscape area. Then the number is standardised, so that the comparison among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated density of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_pd(landscape, "landcover")

#' @export
vm_c_pd <- function(landscape, class){
  patch <- vm_c_np(landscape, class)
  # calculate the total landscape area in square meters
  area <- vm_p_area(landscape, class)
  A <- sum(area$value*10000)

  patch$pd <- patch$value/A * 10000 * 100
  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(patch$class),
    id = as.integer(NA),
    metric = "pd",
    value = as.double(patch$pd)
  )
}
