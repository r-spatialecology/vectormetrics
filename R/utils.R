#' Calculate coefficient of variation
#' @param x numeric vector
#' @keywords internal
#' @noRd

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
#' @noRd
get_ibp <- function(shape, n = 100){
  sf::st_agr(shape) <- "constant"
  ibp = shape |> sf::st_boundary() |> sf::st_sample(n)|> sf::st_cast("POINT")
  ibp = c(ibp, shape |> sf::st_cast("POINT") |> sf::st_geometry())
  ibp
}

#' Get inner grid points for a shape
#' @param shape sf object
#' @param n number of points to generate
#' @keywords internal
#' @noRd
get_igp <- function(shape, n = 1000){
  points <- shape |>
    sf::st_sample(size = n, type = "regular") |>
    sf::st_set_crs(sf::st_crs(shape))
  points
}

#' Prepare class and patch ID columns
#' @param landscape sf object
#' @param class_col class column name
#' @param patch_col patch ID column name
#' @keywords internal
#' @noRd
prepare_columns <- function(landscape, class_col, patch_col){
  if (is.null(patch_col)){
    patch_col <- "id"
    landscape[, patch_col] <- as.character(seq_len(nrow(landscape)))
  } else{
    landscape[, patch_col] <- as.character(landscape[, patch_col, drop = TRUE])
  }
  if (is.null(class_col)){
    class_col <- "class"
    landscape[, class_col] <- "1"
  } else{
    landscape[, class_col] <- as.character(landscape[, class_col, drop = TRUE])
  }

  return(
    list(landscape = landscape, class_col = class_col, patch_col = patch_col)
  )
}
