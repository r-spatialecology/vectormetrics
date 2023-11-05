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

vm_l_perim_idx_mn <- function(landscape, class){
  perim <- vm_p_perim_idx(landscape, class)
  perim_l <- mean(perim$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "perim_mn",
    value = as.double(perim_l)
  )
}
