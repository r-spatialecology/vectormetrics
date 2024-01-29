#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of grid points to generate
#' @return  ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_coh(vector_landscape, "class")
#' @export

vm_l_coh_idx_mn <- function(landscape, class, n = 1000){
  coh <- vm_p_coh(landscape, class, n)
  coh_l <- mean(coh$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "coh_mn",
    value = as.double(coh_l)
  ))
}
