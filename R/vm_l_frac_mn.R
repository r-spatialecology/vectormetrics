#' @title fractal dimension index(vector data)
#'
#' @description This function allows you to calculate index fractal dimension index.
#' The index is based on the patch perimeter and the patch area and describes the patch complexity.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated indice of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_frac(vector_landscape, "class")
#' @export

vm_l_frac_mn <- function(landscape, class){
  frac <- vm_p_frac(landscape, class)
  frac_l <- mean(frac$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "frac_mn",
    value = as.double(frac_l)
  ))
}
