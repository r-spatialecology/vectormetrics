#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return  ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_fullness(vector_landscape, "class")
#' @export

vm_l_full_idx_mn <- function(landscape, class, n = 10000){
  full <- vm_p_fullness(landscape, class, n)
  full_l <- mean(full$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "full_mn",
    value = as.double(full_l)
  ))
}
