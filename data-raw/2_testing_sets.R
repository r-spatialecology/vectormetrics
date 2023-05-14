poz_buldings <- sf::st_read("./testing_sets/buildings.gpkg")
usethis::use_data(poz_buldings, overwrite = TRUE)

clc <- sf::st_read("./testing_sets/clc.gpkg")
usethis::use_data(clc, overwrite = TRUE)

urban_atlas <- sf::st_read("./testing_sets/urbanatlas.gpkg")
usethis::use_data(urban_atlas, overwrite = TRUE)
