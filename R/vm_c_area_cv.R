#' @title The coefficient of variation of all patch areas at class level (vector data)
#' @description This function allows you to calculate the coefficient of variation
#' of all patch areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_area_cv(vector_landscape, "class")

#' @export
vm_c_area_cv <- function(landscape, class){

  # calculate the area of all the patches
  area <- vm_p_area(landscape, class)

  # grouped by the class, and then calculate the Coefficient Of Variation of area in each class,
  area_cv <- aggregate(area$value, by = list(area$class), vm_cv)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_cv[, 1]),
    id = as.integer(NA),
    metric = "area_cv",
    value = as.double(area_cv[, 2])
  )
}
