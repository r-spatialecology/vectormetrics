#' @title Landscape shape index (vector data)
#' 
#' @description This function allows you to calculate the ratio between the actual edge length
#' and the hypothetical minimum edge length in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if the landscape would be maximally aggregated into a circle.
#' @param landscape the input landscape image,
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @details
#' LSI is calculated as: LSI = TE / (2 * pi * sqrt(A/pi))
#' where TE is the total edge (in meters) and A is the total landscape area (in square meters).
#' This uses circle standardization, which is more natural for vector data.
#' An LSI of 1 indicates a perfectly circular landscape.
#' The boundary is included in the calculation (count_boundary=TRUE).
#' @examples
#' vm_l_lsi(vector_landscape)
#' @export

vm_l_lsi <- function(landscape){
  # Get total edge with boundary included
  te <- vm_l_te(landscape, count_boundary = TRUE)
  
  # Get total landscape area in square meters
  area <- vm_p_area(landscape)
  area_m2 <- sum(area$value) * 10000  # convert hectares to m²

  # Calculate LSI using circle standardization: TE / (2 * pi * sqrt(area/pi))
  # Minimum perimeter for a circle: 2 * pi * radius where radius = sqrt(area/pi)
  min_perim <- 2 * pi * sqrt(area_m2 / pi)
  lsi <- te$value / min_perim

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "lsi",
    value = as.double(lsi)
  ))
}
