#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return sqrt(4 * area / pi) / perimeter
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_comp_idx(vector_landscape, "class")
#' @export

vm_l_comp_idx_mn <- function(landscape, class){
  comp <- vm_p_comp_idx(landscape, class)
  comp_l <- mean(comp$value)

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "comp_mn",
    value = as.double(comp_l)
  )
}
