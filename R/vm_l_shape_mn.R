#' @title The mean value of Shape index of landscape (vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of shape index of all patches in a categorical landscape in vector data format
#' shape index is the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @return  the returned calculated mean value of each class is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_shape_mn(vector_landscape)
#' @export

vm_l_shape_mn <- function(landscape){
  shape <- vm_p_shape(landscape)
  shape_mn <- mean(shape$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "shape_mn",
    value = as.double(shape_mn)
  ))
}
