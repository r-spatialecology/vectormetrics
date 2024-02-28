testthat::test_that("check number of patches", {
  expect_equal(nrow(get_patches(vector_landscape, "class", 4)), 35)
  expect_equal(nrow(get_patches(vector_landscape, "class", 8)), 27)
})

testthat::test_that("check get_patches result structure", {
  vl_copy <- vector_landscape
  colnames(vl_copy) <- c("type", "geometry")
  vl <- get_patches(vector_landscape, "class", 4)
  vl2 <- get_patches(vl_copy, "type", 4)
  expect_s3_class(vl, "sf")
  expect_equal(sf::st_bbox(vl), sf::st_bbox(vector_landscape))
  expect_equal(c(colnames(vl_copy), "patch") |> sort(), colnames(vl2) |> sort())
})
