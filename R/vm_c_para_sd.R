#' @title The standard deviation of Perimeter-Area ratio index of all patches at class level(vector data)
#' @description This function allows you to calculate the standard deviation
#' of the ratios of all patches belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_area_sd(landscape, "landcover")

#' @export
vm_c_para_sd <- function(landscape, class){
  para <- vm_p_para(landscape, class)
  # grouped by the class, and then calculate the standard deviation of perimeter-area ratio in each class.
  para_sd <- stats::aggregate(para$value, by= list(para$class), sd)
  names(para_sd) <- c("class", "para_sd")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(para_sd$class),
    id = as.integer(NA),
    metric = "para_sd",
    value = as.double(para_sd$para_sd)
  )
}
