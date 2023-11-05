#' @title Elongation(vector data)
#'
#' @description Calculate elongation of shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between major and minor axis length
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_elong_idx(vector_landscape, "class")
#' @export

vm_l_elong_idx_mn <- function(landscape, class){
  elong <- vm_p_elong_idx(landscape, class)
  elong_l <- mean(elong$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "elong_mn",
    value = as.double(elong_l)
  )
}
