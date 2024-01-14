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

vm_c_range_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  range_idx <- vm_p_range_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  range_mn <- stats::aggregate(range_idx$value, by = list(range_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(range_mn)),
    class = as.integer(range_mn[, 1]),
    id = as.integer(NA),
    metric = rep("range_mn", nrow(range_mn)),
    value = as.double(range_mn[, 2])
  ))
}
