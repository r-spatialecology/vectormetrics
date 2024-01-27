testthat::test_that("check number of patches", {
  expect_equal(nrow(get_patches(vector_landscape, "class", 4)), 35)
  expect_equal(nrow(get_patches(vector_landscape, "class", 8)), 27)
})

testthat::test_that("check get_patches result structure", {
  vl <- get_patches(vector_landscape, "class", 4)
  expect_s3_class(vl, "sf")
  expect_equal(sf::st_bbox(vl), sf::st_bbox(vector_landscape))
})
