#' @title Elongation(vector data)
#'
#' @description Calculate elongation of shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between major and minor axis length
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_elong_idx(vector_landscape, "class")
#' @export

vm_c_elong_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  elong_idx <- vm_p_elong_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  elong_mn <- stats::aggregate(elong_idx$value, by = list(elong_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(elong_mn)),
    class = as.integer(elong_mn[, 1]),
    id = as.integer(NA),
    metric = rep("elong_mn", nrow(elong_mn)),
    value = as.double(elong_mn[, 2])
  ))
}
