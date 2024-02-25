#' @title The total area of each class(vector data)

#' @description This function allows you to calculate the total area
#' of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated total class areas are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' @examples
#' vm_c_ca(vector_landscape, "class")
#' @export

vm_c_ca <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  area_sum <- stats::aggregate(area$value, by = list(area$class), sum, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_sum)),
    class = as.integer(area_sum[, 1]),
    id = as.integer(NA),
    metric = rep("ca", nrow(area_sum)),
    value = as.double(area_sum[, 2])
  ))
}
