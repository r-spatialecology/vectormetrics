#' @title Roughness index(vector data)
#'
#' @description Calculate Roughness index (RI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of boundary points to generate
#' @return HERE WRITE DESCRIPTION OF METRIC
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_c_ri_mn <- function(landscape, class, n = 100){
  # calculate the detour index for all patches
  ri <- vm_p_ri(landscape, class, n)

  # grouped by the class, and then calculate the average value of detour index for each class,
  ri_mn <- stats::aggregate(ri$value, by = list(ri$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(ri_mn)),
    class = as.integer(ri_mn[, 1]),
    id = as.integer(NA),
    metric = rep("ri_mn", nrow(ri_mn)),
    value = as.double(ri_mn[, 2])
  ))
}
