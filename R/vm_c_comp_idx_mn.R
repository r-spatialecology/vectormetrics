#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return sqrt(4 * area / pi) / perimeter
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_comp(vector_landscape, "class")
#' @export

vm_c_comp_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  comp_idx <- vm_p_comp(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  comp_mn <- stats::aggregate(comp_idx$value, by = list(comp_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(comp_mn)),
    class = as.integer(comp_mn[, 1]),
    id = as.integer(NA),
    metric = rep("comp_mn", nrow(comp_mn)),
    value = as.double(comp_mn[, 2])
  ))
}
