#' Coefficient of variation
#'
#' @description Coefficient of variation
#'
#' @param x numeric vector
#'
#' @return tibble
#'
#' @examples
#' vm_p_area(vector_landscape, "class")
#'
#' @aliases vm_p_area
#' @rdname vm_p_area
#'
#' @keywords internal
#'
#' @name vm_p_area
#' @export

vm_cv <- function(x){

  x_mean <- mean(x)
  x_sd   <- sd(x)


  cv <- (x_sd / x_mean) * 100

  return(cv)

}


aggregate(area$value, by= list(area$class), raster::cv)

aggregate(area$value, by= list(area$class), vm_cv)
