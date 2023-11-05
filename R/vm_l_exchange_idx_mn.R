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

vm_l_exchange_idx_mn <- function(landscape, class){
  exchange <- vm_p_exchange_idx(landscape, class)
  exchange_l <- mean(exchange$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "exchange_mn",
    value = as.double(exchange_l)
  )
}
