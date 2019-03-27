#' @title The mean value of Shape index of landscape (vector data)
#' @description This function allows you to calculate the mean value
#' of shape index of all patches in a categorical landscape in vector data format
#' shape index is the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated mean value of each class is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_shape_mn(landscape, "landcover")

#' @export
vm_l_shape_mn <- function(landscape, class){
  shape <- vm_p_shape(landscape, class)
  shape_mn <- mean(shape$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "shape_mn",
    value = as.double(shape_mn)
  )
}
