library(sf)

circle = st_point(c(1, 1)) |> st_buffer(100) |> st_sfc() |> st_sf()
plot(circle)
circle$area = st_area(circle)

fullness = function(building){
  full_idx = function(geom, area, radius){
    buffers = geom %>%
      st_sample(size = 1000, type = "regular") %>%
      st_set_crs(st_crs(geom)) %>%
      st_buffer(radius)

    buffers$fullness = (st_intersection(buffers, geom) %>% st_area()) / area
    mean(buffers$fullness)
  }

  area = building$area * 0.01
  radius = sqrt(area / pi)

  FI = full_idx(building, area, radius)

  building$fullness_index = ifelse(FI > 1, 1, FI)
  building
}

results = c()
progress_bar = txtProgressBar(min = 0, max = 100, style = 3, char = "=")
for (i in 1:100){
  circle = fullness(circle)
  results = c(results, circle$fullness_index)
  setTxtProgressBar(progress_bar, value = i)
}
close(progress_bar)
mean(results)
hist(results, breaks = 20)

