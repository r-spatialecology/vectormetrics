#' @title fractal dimension index(vector data)
#'
#' @description This function allows you to calculate index fractal dimension index.
#' The index is based on the patch perimeter and the patch area and describes the patch complexity.
#' @details 2 * log(perimeter) / log(area)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_frac_mn(vector_landscape, "class")
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
