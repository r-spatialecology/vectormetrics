#' @title the number of patches in each class(vector data)
#' @description This function allows you to calculate the number of patches of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated number of patches of each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_np(landscape, "landcover")

#' @export
vm_c_np <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  patch <- table(area$class)
  patch <- as.data.frame(patch)

  names(patch) <- c("class", "num_patch")
  if (class(patch$class) == "factor"){
    patch$class <- as.numeric(levels(patch$class))[patch$class]
  }
  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(patch$class),
    id = as.integer(1:nrow(patch)),
    metric = "np",
    value = as.integer(patch$num_patch)
  )
}
