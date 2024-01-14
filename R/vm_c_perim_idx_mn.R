#' @title Perimeter Index(vector data)
#'
#' @description Calculate Perimeter Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_c_perim_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  perim_idx <- vm_p_perim_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  perim_mn <- stats::aggregate(perim_idx$value, by = list(perim_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(perim_mn)),
    class = as.integer(perim_mn[, 1]),
    id = as.integer(NA),
    metric = rep("perim_mn", nrow(perim_mn)),
    value = as.double(perim_mn[, 2])
  ))
}
