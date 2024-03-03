#' @title The mean value of all patch areas at class level(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of all patch areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated mean value of areas of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' @examples
#' vm_c_area_mn(vector_landscape, "class")
#' @export

vm_c_area_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the area of all the patches
  area <- vm_p_area(landscape, class)

  # grouped by the class, and then calculate the mean value
  area_mn <- stats::aggregate(area$value, by = list(area$class), mean, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_mn)),
    class = as.character(area_mn[, 1]),
    id = as.character(NA),
    metric = rep("area_mn", nrow(area_mn)),
    value = as.double(area_mn[, 2])
  ))
}
