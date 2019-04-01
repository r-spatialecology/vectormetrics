#' @title The standard deviation of Euclidean Nearest-Neighbor Distance of patches in each class(vector data)
#' @description This function allows you to calculate the standard deviation
#' of Euclidean Nearest-Neighbor Distance among patches of one class in a categorical landscape in vector data format
#' @param landscape the input landscape image, should in "POLYGON" or "MULTIPOLYGON" form.
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated standard deviation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_enn_sd(vector_landscape, "class")

#' @export
vm_c_enn_sd <- function(landscape, class){
  enn <- vm_p_enn(landscape, class)
  # grouped by the class, and then calculate the standard deviation of euclidean nearest-neighbor distance in each class.
  enn_sd <- stats::aggregate(enn$value, by= list(enn$class), sd)
  names(enn_sd) <- c("class", "enn_sd")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(enn_sd$class),
    id = as.integer(NA),
    metric = "enn_sd",
    value = as.double(enn_sd$enn_sd)
  )
}
