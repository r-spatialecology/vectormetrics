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

vm_cv <- function(x){

  x_mean <- mean(x)
  x_sd   <- sd(x)

  cv <- (x_sd / x_mean) * 100

  return(cv)

}

# aggregate(area$value, by= list(area$class), raster::cv)
# aggregate(area$value, by= list(area$class), vm_cv)
