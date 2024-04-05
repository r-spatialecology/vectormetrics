square <- list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(square) <- "geometry"
square$class <- 1

diamond <- list(cbind(c(0,4,8,4,0), c(0,2,0,-2,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(diamond) <- "geometry"
diamond$class <- 1

circle <- sf::st_point(c(22220, 22220)) |> sf::st_sfc(crs = "EPSG:2180") |>
  sf::st_buffer(1L) |> sf::st_sf()
sf::st_geometry(circle) <- "geometry"
circle$class <- 1

squaretxt <- list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
sf::st_geometry(squaretxt) <- "geometry"
squaretxt$class <- "text"

small_shape <- data.frame(class = 1, geometry = "Polygon((723185.63000000000465661 484177.21000000002095476, 723185.64000000001396984 484177.21999999997206032, 723185.64000000001396984 484177.21000000002095476, 723185.63000000000465661 484177.21000000002095476))") |> 
  sf::st_as_sf(wkt = "geometry", crs = 2180)
