square = list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |> sf::st_sfc() |> sf::st_sf()
square$class = 1
sf::st_geometry(square) = "geometry"
diameter = vm_p_circum(square, "class")$value
range_index = vm_p_range_idx(square, "class")$value

testthat::test_that("test testu", {
  expect_equal(diameter, 1.41, tolerance = 0.01)
  expect_equal(range_index, 0.7978843, tolerance = 0.001)
})
