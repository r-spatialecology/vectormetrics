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

vm_c_sq_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  sq_idx <- vm_p_sq_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  sq_mn <- stats::aggregate(sq_idx$value, by = list(sq_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(sq_mn[, 1]),
    id = as.integer(NA),
    metric = "sq_mn",
    value = as.double(sq_mn[, 2])
  )
}
