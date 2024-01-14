#' @title Convexity(vector data)
#'
#' @description Calculate convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of convex hull and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_conv_idx(vector_landscape, "class")
#' @export

vm_c_conv_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  conv_idx <- vm_p_conv_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  conv_mn <- stats::aggregate(conv_idx$value, by = list(conv_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(conv_mn)),
    class = as.integer(conv_mn[, 1]),
    id = as.integer(NA),
    metric = rep("conv_mn", nrow(conv_mn)),
    value = as.double(conv_mn[, 2])
  ))
}
