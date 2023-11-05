#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_coh_idx(vector_landscape, "class")
#' @export

vm_c_coh_idx_mn <- function(landscape, class, n = 1000){
  # calculate the detour index for all patches
  coh_idx <- vm_p_coh_idx(landscape, class, n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  coh_mn <- stats::aggregate(coh_idx$value, by = list(coh_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(coh_mn[, 1]),
    id = as.integer(NA),
    metric = "coh_mn",
    value = as.double(coh_mn[, 2])
  )
}
