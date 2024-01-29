#' @title Roughness index(vector data)
#'
#' @description Calculate Roughness index (RI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of boundary points to generate
#' @return HERE WRITE DESCRIPTION OF METRIC
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_l_ri_mn <- function(landscape, class, n = 100){
  ri <- vm_p_ri(landscape, class, n)
  ri_l <- mean(ri$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "ri_mn",
    value = as.double(ri_l)
  ))
}
