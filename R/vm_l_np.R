#' @title the number of patches in each class(vector data)
#' @description This function allows you to calculate the number of patches of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated number of patches of each class is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_np(vector_landscape, "class")

#' @export
vm_l_np <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  np <- length(area$class)
  
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "np",
    value = as.double(np)
  ))
}
