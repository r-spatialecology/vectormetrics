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

vm_c_rect_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  rect_idx <- vm_p_rect_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  rect_mn <- stats::aggregate(rect_idx$value, by = list(rect_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(rect_mn)),
    class = as.integer(rect_mn[, 1]),
    id = as.integer(NA),
    metric = rep("rect_mn", nrow(rect_mn)),
    value = as.double(rect_mn[, 2])
  ))
}
