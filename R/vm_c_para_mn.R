#' @title The mean value of all patches Perimeter-Area ratio index at class level(vector data)
#' @description This function allows you to calculate the mean value
#' of all patch ratios belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated mean value of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.

#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_para_mn(landscape, "landcover")

#' @export
vm_c_para_mn <- function(landscape, class){
  para <- vm_p_para(landscape, class)
  # grouped by the class, and then calculate the mean value of perimeter-area ratio in each class.
  para_mn <- aggregate(para$value, by= list(para$class), mean)
  names(para_mn) <- c("class", "para_mn")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(para_mn$class),
    id = as.integer(NA),
    metric = "para_mn",
    value = as.double(para_mn$para_mn)
  )
}
