#' @title Rectangularity(vector data)
#'
#' @description Calculate rectangularity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of shape and its minimum area bounding rectangle (MABR)
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_rect_idx(vector_landscape, "class")
#' @export

vm_l_rect_idx_mn <- function(landscape, class){
  rect <- vm_p_rect_idx(landscape, class)
  rect_l <- mean(rect$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "rect_mn",
    value = as.double(rect_l)
  )
}
