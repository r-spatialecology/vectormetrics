#' @title Core area percentage of landscape in each class(vector data)
#'
#' @description This function allows you to calculate the total core area of each class
#' in relation to the landscape area in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated ratios are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_cpland(landscape, "landcover", core_distance = 1)

#' @export
vm_c_cpland <- function(landscape, class, core_distance){
  # the total landscape area
  area <- vm_p_area(landscape, class)
  sum_landscape <- sum(area$value)

  core <- vm_p_core(landscape, class, core_distance)
  # grouped by the class, and then calculate the sum of core area in each class.
  core_sum <- stats::aggregate(core$value, by= list(core$class), sum)
  names(core_sum) <- c("class", "core_sum")

  # calculating the Core area percentage of landscape
  core_sum$cpland <- (core_sum$core_sum/sum_landscape) * 100
  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(core_sum$class),
    id = as.integer(NA),
    metric = "cpland",
    value = as.double(core_sum$cpland)
  )
}
