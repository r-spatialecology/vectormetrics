#' @export
get_ibp <- function(shape, n = 100){
  ibp = shape |> sf::st_boundary() |> sf::st_sample(n) |> sf::st_cast("POINT")
  ibp = c(ibp, shape|> sf::st_cast("POINT") |> sf::st_geometry())
  ibp
}
