#' @title Solidity(vector data)
#'
#' @description Solidity convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of convex hull and area of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_solid(vector_landscape, "class")
#' @export

vm_c_solid_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  solid_idx <- vm_p_solid(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  solid_mn <- stats::aggregate(solid_idx$value, by = list(solid_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(solid_mn)),
    class = as.integer(solid_mn[, 1]),
    id = as.integer(NA),
    metric = rep("solid_mn", nrow(solid_mn)),
    value = as.double(solid_mn[, 2])
  ))
}
