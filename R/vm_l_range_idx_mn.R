#' @title Range Index(vector data)
#'
#' @description Calculate Range Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between diameter of equal-area circle and diameter of smallest circumscribing circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_l_range_idx_mn <- function(landscape, class){
  range <- vm_p_range_idx(landscape, class)
  range_l <- mean(range$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "range_mn",
    value = as.double(range_l)
  ))
}
