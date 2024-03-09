#' @title Patch richness density (vector data)
#'
#' @description This function allows you to calculate the Patch richness density
#' in a categorical landscape in vector data format, Patch richness density is diversity index
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_prd(vector_landscape, "class")
#' @export

vm_l_prd <- function(landscape, class_col){
  n_class <- length(unique(landscape[, class_col, drop = TRUE]))
  area <- vm_l_ta(landscape)$value
  A <- sum(area * 10000)
  prd <- n_class / A * 10000 * 100

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "prd",
    value = as.double(prd)
  ))
}
