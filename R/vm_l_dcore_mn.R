#' @title The mean value of number of core areas in landscape(vector data)
#' @description This function allows you to calculate the mean value
#' of the total number of disjunct core areas in a categorical landscape in vector data format

#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of number of the whole landscape is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_dcore_mn(landscape, "landcover", core_distance= 1)

#' @export
vm_l_dcore_mn <- function(landscape, class, core_distance){
  ncore <- vm_p_ncore(landscape, class, core_distance)
  ncore_l <- mean(ncore$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "dcore_mn",
    value = as.double(ncore_l)
  )
}
