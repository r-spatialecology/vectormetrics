#' @title Edge density(vector data)
#' 
#' @description This function allows you to calculate the edge density of class i in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param count_boundary Include landscape boundary in edge length (default: TRUE)
#' @return  the returned calculated length is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @details
#' Edge density is calculated as the total edge length divided by total landscape area (in m/ha).
#' 
#' Note: The default differs from landscapemetrics (default: FALSE) because vector
#' polygon boundaries are explicit geometric features. Set count_boundary=FALSE for
#' direct comparison with landscapemetrics results.
#' @examples
#' vm_c_ed(vector_landscape, "class")
#' vm_c_ed(vector_landscape, "class", count_boundary = FALSE)
#' @export

vm_c_ed <- function(landscape, class_col, count_boundary = TRUE){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # Get class-specific total edge
  te <- vm_c_te(landscape, class_col, count_boundary = count_boundary)
  
  # total landscape area in hectares
  area <- vm_p_area(landscape, class_col)
  area_sum <- sum(area$value)  # hectares
  
  # ED = class total edge (m) / landscape total area (ha) = meters per hectare
  te$ED <- te$value / area_sum

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(te)),
    class = as.character(te$class),
    id = as.character(NA),
    metric = rep("ed", nrow(te)),
    value = as.double(te$ED)
  ))
}
