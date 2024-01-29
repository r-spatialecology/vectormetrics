#' Calculate coefficient of variation
#' @param x numeric vector
#' @keywords internal
#' @NoRd

vm_cv <- function(x, na_rm = FALSE){
  x_mean <- mean(x, na.rm = na_rm)
  x_sd <- stats::sd(x, na.rm = na_rm)
  cv <- (x_sd / x_mean) * 100

  return(cv)
}

#' Get boundary points of a shape
#' @param shape sf object
#' @param n number of points to generate
#' @keywords internal
#' @NoRd
get_ibp <- function(shape, n = 100){
  ibp = shape |> sf::st_boundary() |> sf::st_sample(n) |> sf::st_cast("POINT")
  ibp = c(ibp, shape |> sf::st_cast("POINT") |> sf::st_geometry())
  ibp
}

#' Get inner grid points for a shape
#' @param shape sf object
#' @param n number of points to generate
#' @keywords internal
#' @NoRd
get_igp <- function(shape, n = 1000){
  points <- shape |>
    sf::st_sample(size = n, type = "regular") |>
    sf::st_set_crs(sf::st_crs(shape))
  points
}