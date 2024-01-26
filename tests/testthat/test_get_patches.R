testthat::test_that("check number of patches", {
  expect_equal(nrow(get_patches(vector_landscape, "class", 4)), 35)
  expect_equal(nrow(get_patches(vector_landscape, "class", 8)), 27)
})
