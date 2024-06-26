#' @title Modified Simpson's diversity index (vector data)
#'
#' @description This function allows you to calculate the Modified Simpson's diversity index
#' in a categorical landscape in vector data format, Modified Simpson's diversity index is diversity index
#' @param landscape the input landscape image
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_msidi(vector_landscape, "class")
#' @export

vm_l_msidi <- function(landscape, class_col){
  area_class <- vm_c_ca(landscape, class_col)
  area_class$value <- area_class$value * 10000
  A <- sum(area_class$value)
  area_class["pro"] <- (area_class$value / A) ^ 2
  msidi <- -log(sum(area_class$pro))

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "msidi",
    value = as.double(msidi)
  ))
}
