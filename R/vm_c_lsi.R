#' @title Landscape shape index (vector data)
#' 
#' @description This function allows you to calculate the ratio between the actual edge length of class i
#' and the hypothetical minimum edge length of class i in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if class i would be maximally aggregated into a circle.
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @details
#' LSI is calculated as: LSI = TE / (2 * pi * sqrt(CA/pi))
#' where TE is the total edge (in meters) and CA is the class area (in square meters).
#' This uses circle standardization, which is more natural for vector data.
#' An LSI of 1 indicates a perfectly circular class.
#' Note: This differs from landscapemetrics which uses square standardization.
#' @examples
#' vm_c_lsi(vector_landscape, "class")
#' @export

vm_c_lsi <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # Get total edge for each class (union boundary)
  te <- vm_c_te(landscape, class_col, count_boundary = TRUE)
  
  # Get class area in square meters
  area <- vm_c_ca(landscape, class_col)
  area_m2 <- area$value * 10000  # convert hectares to m²
  
  # Calculate LSI using circle standardization: TE / (2 * pi * sqrt(area/pi))
  # Minimum perimeter for a circle: 2 * pi * radius where radius = sqrt(area/pi)
  min_perim <- 2 * pi * sqrt(area_m2 / pi)
  lsi <- te$value / min_perim

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(te)),
    class = as.character(te$class),
    id = as.character(NA),
    metric = rep("lsi", nrow(te)),
    value = as.double(lsi)
  ))
}
