#' @title Sphrecity(vector data)
#'
#' @description Calculate sphercity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sph(vector_landscape, "class")
#' @export

vm_c_sph_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  sph_idx <- vm_p_sph(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  sph_mn <- stats::aggregate(sph_idx$value, by = list(sph_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(sph_mn)),
    class = as.integer(sph_mn[, 1]),
    id = as.integer(NA),
    metric = rep("sph_mn", nrow(sph_mn)),
    value = as.double(sph_mn[, 2])
  ))
}
