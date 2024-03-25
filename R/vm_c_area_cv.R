#' @title The coefficient of variation of all patch areas at class level (vector data)
#' 
#' @description This function allows you to calculate the coefficient of variation
#' of all patch areas belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of areas of each class is in column "value",
#' this function returns also some important information such as level, class number and metric name.
#' @examples
#' vm_c_area_cv(vector_landscape, "class")
#' @export

vm_c_area_cv <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the area of all the patches
  area <- vm_p_area(landscape, class_col)

  # grouped by the class, and then calculate the Coefficient Of Variation of area in each class,
  area_cv <- stats::aggregate(area$value, by = list(area$class), vm_cv)
  
  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_cv)),
    class = as.character(area_cv[, 1]),
    id = as.character(NA),
    metric = rep("area_cv", nrow(area_cv)),
    value = as.double(area_cv[, 2])
  ))
}
