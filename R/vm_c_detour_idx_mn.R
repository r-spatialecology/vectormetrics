#' @title Detour Index(vector data)
#'
#' @description Calculate Detour Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of convex hull of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_detour_idx_mn(vector_landscape, "class")
#' @export

vm_c_detour_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  detour_idx <- vm_p_detour_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  detour_mn <- stats::aggregate(detour_idx$value, by = list(detour_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(detour_mn[, 1]),
    id = as.integer(NA),
    metric = "detour_mn",
    value = as.double(detour_mn[, 2])
  )
}
