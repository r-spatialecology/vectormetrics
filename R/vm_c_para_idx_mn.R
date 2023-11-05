#' @title Perimeter-Area ratio.
#'
#' @description This function allows you to calculate the ratio between the patch area and perimeter.
#' The ratio describes the patch complexity in a straightforward way.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the function returns the calculated ratio of all patches in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_para_idx(vector_landscape, "class")
#' @export

vm_c_para_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  para_idx <- vm_p_para_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  para_mn <- stats::aggregate(para_idx$value, by = list(para_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(para_mn[, 1]),
    id = as.integer(NA),
    metric = "para_mn",
    value = as.double(para_mn[, 2])
  )
}
