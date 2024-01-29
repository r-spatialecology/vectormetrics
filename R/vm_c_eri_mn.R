#' @title Equivalent rectangular index(vector data)
#'
#' @description Calculate Equivalent rectangular index (ERI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area rectangle of shape and perimeter of shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_square(vector_landscape, "class")
#' @export

vm_c_eri_mn <- function(landscape, class){
  # calculate the detour index for all patches
  eri <- vm_p_eri(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  eri_mn <- stats::aggregate(eri$value, by = list(eri$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(eri_mn)),
    class = as.integer(eri_mn[, 1]),
    id = as.integer(NA),
    metric = rep("eri_mn", nrow(eri_mn)),
    value = as.double(eri_mn[, 2])
  ))
}
