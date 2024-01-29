#' @title Girth Index(vector data)
#'
#' @description Calculate Girth Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between radius of maximum inscribed circle and radius of equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_girth(vector_landscape, "class")
#' @export

vm_c_girth_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  girth_idx <- vm_p_girth(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  girth_mn <- stats::aggregate(girth_idx$value, by = list(girth_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(girth_mn)),
    class = as.integer(girth_mn[, 1]),
    id = as.integer(NA),
    metric = rep("girth_mn", nrow(girth_mn)),
    value = as.double(girth_mn[, 2])
  ))
}
