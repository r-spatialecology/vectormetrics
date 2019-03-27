#' @title The coefficient of variation of ratio of the core area and the area at class level(vector data)
#'
#' @description This function allows you to calculate the coefficient of variation
#' of the ratio of the core area and the area belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated coefficient of variation of ratio of the core area and the area of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_cai_cv(landscape, "landcover", core_distance = 1)

#' @export

vm_c_cai_cv <- function(landscape, class, core_distance){
  cai <- vm_p_cai(landscape, class, core_distance)
  # grouped by the class, and then calculate the Coefficient Of Variation of core area index in each class.
  cai_cv <- aggregate(cai$value, by= list(cai$class), cv)
  names(cai_cv) <- c("class", "cai_cv")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(cai_cv$class),
    id = as.integer(NA),
    metric = "cai_cv",
    value = as.double(cai_cv$cai_cv)
  )
}
