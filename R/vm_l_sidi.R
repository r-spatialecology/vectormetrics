#' @title Simpson's diversity index (vector data)
#'
#' @description This function allows you to calculate the Simpson's diversity index
#' in a categorical landscape in vector data format, Simpson's diversity index is diversity index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_sidi(vector_landscape, "class")
#' @export

vm_l_sidi <- function(landscape, class){
  area_class <- vm_c_ca(landscape, class)
  area_class$value <- area_class$value * 10000
  A <- sum(area_class$value)
  area_class["pro"] <- area_class$value / A
  sidi <- 1 - sum((area_class$pro) ^ 2)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "sidi",
    value = as.double(sidi)
  ))
}
