#' @title the number of patches in landscape(vector data)
#' 
#' @description This function allows you to calculate the number of patches in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_np(vector_landscape)
#' @export

vm_l_np <- function(landscape){
  np <- nrow(landscape)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "np",
    value = as.double(np)
  ))
}
