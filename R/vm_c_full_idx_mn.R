#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return  ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_full_idx(vector_landscape, "class")
#' @export

vm_c_full_idx_mn <- function(landscape, class, n = 10000){
  # calculate the detour index for all patches
  full_idx <- vm_p_full_idx(landscape, class, n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  full_mn <- stats::aggregate(full_idx$value, by = list(full_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(full_mn)),
    class = as.integer(full_mn[, 1]),
    id = as.integer(NA),
    metric = rep("full_mn", nrow(full_mn)),
    value = as.double(full_mn[, 2])
  ))
}
