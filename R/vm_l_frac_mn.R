#' @title The mean value of the fractal dimension index of landscape(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of fractal dimension index in a categorical landscape in vector data format
#' The index is based on the patch perimeter and the patch area and describes the patch complexity
#' @param landscape the input landscape image
#' @return  the returned calculated mean value of the whole landscape is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_frac_mn(vector_landscape)
#' @export

vm_l_frac_mn <- function(landscape){
  frac <- vm_p_frac(landscape)
  frac_l <- mean(frac$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "frac_mn",
    value = as.double(frac_l)
  ))
}
