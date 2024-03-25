poz_buildings <- sf::st_read("./testing_sets/buildings.gpkg")
sf::st_geometry(poz_buildings) <- "geometry"
poz_buildings$building <- factor(poz_buildings$building)
usethis::use_data(poz_buildings, overwrite = TRUE)

clc <- sf::st_read("./testing_sets/clc.gpkg")
sf::st_geometry(clc) <- "geometry"
usethis::use_data(clc, overwrite = TRUE)

urban_atlas <- sf::st_read("./testing_sets/urbanatlas.gpkg")
sf::st_geometry(urban_atlas) <- "geometry"
usethis::use_data(urban_atlas, overwrite = TRUE)
