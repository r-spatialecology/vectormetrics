#' @title The standard deviation of all patch areas at class level(vector data)
#' @description This function allows you to calculate the standard deviation
#' of all patch areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' @examples
#' vm_c_area_sd(vector_landscape, "class")
#' @export

vm_c_area_sd <- function(landscape, class){
  # calculate the area of all the patches
  area <- vm_p_area(landscape, class)

  # grouped by the class, and then calculate the standard deviation of area
  area_sd <- stats::aggregate(area$value, by = list(area$class), stats::sd, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_sd)),
    class = as.integer(area_sd[, 1]),
    id = as.integer(NA),
    metric = rep("area_sd", nrow(area_sd)),
    value = as.double(area_sd[, 2])
  ))
}
