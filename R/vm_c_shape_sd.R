#' @title The standard deviation of Shape index of each class (vector data)
#' @description This function allows you to calculate the standard deviation
#' of shape index of all patches belonging to one class in a categorical landscape in vector data format
#' shape index is the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_shape_sd(vector_landscape, "class")

#' @export
vm_c_shape_sd <- function(landscape, class){

  shape <- vm_p_shape(landscape, class)

  shape_sd <- stats::aggregate(shape$value,
                               by= list(shape$class),
                               sd,
                               na.rm = TRUE)


  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(shape_sd[, 1]),
    id = as.integer(NA),
    metric = "shape_sd",
    value = as.double(shape_sd[, 2])
  )
}
