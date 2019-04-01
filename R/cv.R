#' Coefficient of variation
#'
#' @description Coefficient of variation
#'
#' @param x numeric vector
#'
#' @return tibble
#'
#' @keywords internal
#'
#' @name vm_cv
#' @export

vm_cv <- function(x, na.rm = TRUE){

  x_mean <- mean(x, na.rm = na.rm)
  x_sd   <- sd(x, na.rm = na.rm)

  cv <- (x_sd / x_mean) * 100

  return(cv)

}

# stats::aggregate(area$value, by= list(area$class), raster::cv)
# stats::aggregate(area$value, by= list(area$class), vm_cv)
