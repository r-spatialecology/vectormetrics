#' @title The mean value of number of core areas in each class(vector data)
#' @description This function allows you to calculate the mean value
#' of the total number of disjunct core areas belonging to one class in a categorical landscape in vector data format

#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of number of core areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.

#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_dcore_mn(vector_landscape, "class", core_distance= 1)

#' @export
vm_c_dcore_mn <- function(landscape, class, core_distance){
  dcore <- vm_p_ncore(landscape, class, core_distance)
  # grouped by the class, and then calculate the mean value of the number of disjunct core areas in each class.
  dcore_mn <- stats::aggregate(dcore$value, by= list(dcore$class), mean)
  names(dcore_mn) <- c("class", "dcore_mn")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(dcore_mn$class),
    id = as.integer(NA),
    metric = "dcore_mn",
    value = as.double(dcore_mn$dcore_mn)
  )
}
