#' @title The mean value of all core areas in landscape(vector data)
#' @description This function allows you to calculate the mean value
#' of all core patch areas in a categorical landscape in vector data format

#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated mean value of core area of the whole landscape is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_core_mn(landscape, "landcover", core_distance= 1)

#' @export
vm_l_core_mn <- function(landscape, class, core_distance){
  core <- vm_p_core(landscape, class, core_distance)
  core_l <- mean(core$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "core_mn",
    value = as.double(core_l)
  )
}