#' @title The total area of the whole landscape(vector data)

#' @description This function allows you to calculate the total area
#' of the whole landscape in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_ta(vector_landscape)
#' @export

vm_l_ta <- function(landscape){
  area <- vm_p_area(landscape)
  ca <- sum(area$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "ta",
    value = as.double(ca)
  ))
}
