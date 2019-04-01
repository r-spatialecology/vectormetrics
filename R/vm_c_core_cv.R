#' @title The coefficient of variation of each class core areas(vector data)
#' @description This function allows you to calculate the coefficient of variation
#' of all patch core areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated coefficient of variation of core areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_core_cv(landscape, "landcover", core_distance= 1)

#' @export
vm_c_core_cv <- function(landscape, class, core_distance){
  core <- vm_p_core(landscape, class, core_distance)
  # grouped by the class, and then calculate the Coefficient Of Variation of core area index in each class.
  core_cv <- stats::aggregate(core$value, by= list(core$class), cv)
  names(core_cv) <- c("class", "core_cv")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(core_cv$class),
    id = as.integer(NA),
    metric = "core_cv",
    value = as.double(core_cv$core_cv)
  )
}
