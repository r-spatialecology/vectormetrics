square <- list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(square) <- "geometry"
square$class <- 1

diamond <- list(cbind(c(0,4,8,4,0), c(0,2,0,-2,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(diamond) <- "geometry"
diamond$class <- 1

circle <- sf::st_point(c(0, 0)) |> sf::st_buffer(1) |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(circle) <- "geometry"
circle$class <- 1

squaretxt <- list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(squaretxt) <- "geometry"
squaretxt$class <- "text"