#' @title The coefficient of variation of Euclidean Nearest-Neighbor Distance of all patches at class level(vector data)
#' @description This function allows you to calculate the coefficient of variation
#' of the Euclidean Nearest-Neighbor Distance among patches of one class in a categorical landscape in vector data format
#' Euclidean Nearest-Neighbor Distance means the distance from a patch edge to the nearest neighbouring patch belonging to the
#' same class.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated coefficient of variation of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_enn_cv(landscape, "landcover")

#' @export
vm_c_enn_cv <- function(landscape, class){
  enn <- vm_p_enn(landscape, class)
  # grouped by the class, and then calculate the Coefficient Of Variation of euclidean nearest-neighbor distance in each class.
  enn_cv <- aggregate(enn$value, by= list(enn$class), cv)
  names(enn_cv) <- c("class", "enn_cv")

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(enn_cv$class),
    id = as.integer(NA),
    metric = "enn_cv",
    value = as.double(enn_cv$enn_cv)
  )
}
