#' @title The standard deviation of all patch areas at class level(vector data)
#' @description This function allows you to calculate the standard deviation
#' of all patch areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_area_sd(landscape, "landcover")

#' @export
vm_c_area_sd <- function(landscape, class){
  # calculate the area of all the patches
  area <- vm_p_area(landscape, class)
  # grouped by the class, and then calculate the standard deviation of area in each class,
  area_sd <- aggregate(area$value, by= list(area$class), sd)
  names(area_sd) <- c("class", "area_sd")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_sd$class),
    id = as.integer(NA),
    metric = "area_sd",
    value = as.double(area_sd$area_sd)
  )
}
