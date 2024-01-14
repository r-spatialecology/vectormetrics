#' @title The total area of the whole landscape(vector data)

#' @description This function allows you to calculate the total area
#' of the whole landscape in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated total class areas are in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_ta(vector_landscape, "class")

#' @export
vm_l_ta <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  area$value <- area$value
  ca <- sum(area$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "ta",
    value = as.double(ca)
  ))
}
