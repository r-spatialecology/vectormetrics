#' @title The mean value of Shape index of each class (vector data)
#' @description This function allows you to calculate the mean value
#' of shape index of all patches belonging to one class in a categorical landscape in vector data format
#' shape index is the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated mean value of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_shape_mn(vector_landscape, "class")

#' @export
vm_c_shape_mn <- function(landscape, class){
  shape <- vm_p_shape(landscape, class)
  # grouped by the class, and then calculate the mean value of shape index in each class.
  shape_mn <- stats::aggregate(shape$value, by= list(shape$class), mean)
  names(shape_mn) <- c("class", "shape_mn")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(shape_mn$class),
    id = as.integer(NA),
    metric = "shape_mn",
    value = as.double(shape_mn$shape_mn)
  )
}
