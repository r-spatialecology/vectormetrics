#' @title Equivalent rectangular index(vector data)
#'
#' @description Calculate Equivalent rectangular index (ERI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area rectangle of shape and perimeter of shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_l_eri_mn <- function(landscape, class){
  eri <- vm_p_eri(landscape, class)
  eri_l <- mean(eri$value)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "eri_mn",
    value = as.double(eri_l)
  ))
}
