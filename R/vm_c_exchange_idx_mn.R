#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return share of the total area of the shape that is inside the equal-area circle about its centroid
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_c_exchange_idx_mn <- function(landscape, class){
  # calculate the detour index for all patches
  exchange_idx <- vm_p_exchange_idx(landscape, class)

  # grouped by the class, and then calculate the average value of detour index for each class,
  exchange_mn <- stats::aggregate(exchange_idx$value, by = list(exchange_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(exchange_mn)),
    class = as.integer(exchange_mn[, 1]),
    id = as.integer(NA),
    metric = rep("exchange_mn", nrow(exchange_mn)),
    value = as.double(exchange_mn[, 2])
  ))
}
