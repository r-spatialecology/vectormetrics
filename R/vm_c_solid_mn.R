#' @title Solidity(vector data)
#'
#' @description Solidity convexity
#' @details ratio between area of convex hull and area of polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_solid_mn(vector_landscape, "class")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_c_solid_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the solidity for all patches
  solid_idx <- vm_p_solid(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  solid_mn <- stats::aggregate(solid_idx$value, by = list(solid_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(solid_mn)),
    class = as.character(solid_mn[, 1]),
    id = as.character(NA),
    metric = rep("solid_mn", nrow(solid_mn)),
    value = as.double(solid_mn[, 2])
  ))
}
