#' @title Circularity(vector data)
#'
#' @description Circularity convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of polygon and area of equal-perimeter circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_circ(vector_landscape, "class")
#' @export

vm_c_circ_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  circ_idx <- vm_p_circ(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  circ_mn <- stats::aggregate(circ_idx$value, by = list(circ_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(circ_mn)),
    class = as.integer(circ_mn[, 1]),
    id = as.integer(NA),
    metric = rep("circ_mn", nrow(circ_mn)),
    value = as.double(circ_mn[, 2])
  ))
}
