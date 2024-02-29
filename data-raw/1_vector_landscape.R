# Create example datasets -------------------------------------------------
set.seed(2024-02-29)
single_landscape_create = function(x) {
  NLMR::nlm_randomcluster(
    ncol = 30,
    nrow = 30,
    p = 0.4,
    ai = c(0.25, 0.25, 0.5),
    rescale = FALSE
  )
}

# Example maps from NLMR --------------------------------------------------
vector_landscape <- single_landscape_create()
names(vector_landscape) <- "class"
vector_landscape <- raster::rasterToPolygons(vector_landscape, dissolve = TRUE)
vector_landscape <- sf::st_as_sf(vector_landscape)

usethis::use_data(vector_landscape, overwrite = TRUE)
