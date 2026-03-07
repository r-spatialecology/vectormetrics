#' @title Relative patch richness (vector data)
#'
#' @description This function allows you to calculate the Relative patch richness
#' in a categorical landscape in vector data format, Relative patch richness is diversity index
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param classes_max the maximal number of class in your input landscape image
#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_rpr(vector_landscape, classes_max = 3)
#' @export

vm_l_rpr <- function(landscape, class_col, classes_max){
  n_class <- length(unique(landscape[, class_col, drop = TRUE]))
  rpr <- n_class / classes_max * 100

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "rpr",
    value = as.double(rpr)
  ))
}
