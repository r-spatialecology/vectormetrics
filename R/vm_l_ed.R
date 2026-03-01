#' @title ED (landscape level)
#' 
#' @description This function allows you to calculate the edge density (meters per hectare) 
#' for the entire landscape in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param count_boundary Include landscape boundary in edge length (default: TRUE)
#' @return  the returned calculated edge density is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @details
#' Edge density equals the sum of all edges divided by total landscape area.
#' The count_boundary parameter is passed to vm_l_te.
#' 
#' Note: The default differs from landscapemetrics (default: FALSE) because vector
#' polygon boundaries are explicit geometric features. Set count_boundary=FALSE for
#' direct comparison with landscapemetrics results.
#' @examples
#' vm_l_ed(vector_landscape)
#' vm_l_ed(vector_landscape, count_boundary = FALSE)
#' @export

vm_l_ed <- function(landscape, count_boundary = TRUE){
  # Get total edge (with proper handling of shared edges)
  te <- vm_l_te(landscape, count_boundary = count_boundary)
  te_sum <- te$value  # meters

  # total area in the landscape (in hectares)
  area <- vm_p_area(landscape)
  area_sum <- sum(area$value)  # hectares
  
  # ED = total edge (m) / total area (ha) = meters per hectare
  ed <- te_sum / area_sum

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "ed",
    value = as.double(ed)
  ))
}
