#' @title Squareness(vector data)
#'
#' @description Calculate squareness
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area square of shape and perimeter of shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_l_sq_idx_mn <- function(landscape, class){
  sq <- vm_p_sq_idx(landscape, class)
  sq_l <- mean(sq$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "sq_mn",
    value = as.double(sq_l)
  ))
}
