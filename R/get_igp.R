#' @export
get_igp <- function(shape, n = 1000){
  points <- shape %>%
    sf::st_sample(size = n, type = "regular") %>%
    sf::st_set_crs(sf::st_crs(shape))
  points
}
