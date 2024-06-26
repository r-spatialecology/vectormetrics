#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @details share of the total area of the shape that is inside the equal-area circle about its centroid
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_exchange_mn(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_exchange_mn <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # calculate the detour index for all patches
  exchange_idx <- vm_p_exchange(landscape, class_col)

  # grouped by the class, and then calculate the average value of detour index for each class,
  exchange_mn <- stats::aggregate(exchange_idx$value, by = list(exchange_idx$class), mean, na.rm = TRUE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(exchange_mn)),
    class = as.character(exchange_mn[, 1]),
    id = as.character(NA),
    metric = rep("exchange_mn", nrow(exchange_mn)),
    value = as.double(exchange_mn[, 2])
  ))
}
