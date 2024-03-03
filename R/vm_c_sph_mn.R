#' @title Sphercity(vector data)
#'
#' @description Calculate sphercity
#' @details ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_sph_mn(vector_landscape, "class")
#' @export

vm_c_sph_mn <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  # calculate the sphercity for all patches
  sph_idx <- vm_p_sph(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  sph_mn <- stats::aggregate(sph_idx$value, by = list(sph_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(sph_mn)),
    class = as.character(sph_mn[, 1]),
    id = as.character(NA),
    metric = rep("sph_mn", nrow(sph_mn)),
    value = as.double(sph_mn[, 2])
  ))
}
