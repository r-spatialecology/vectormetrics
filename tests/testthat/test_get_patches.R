patches4 = get_patches(vector_landscape, "class", 4)
patches8 = get_patches(vector_landscape, "class", 8)

testthat::test_that("check number of patches", {
  expect_equal(nrow(patches4), 35)
  expect_equal(nrow(patches8), 27)
})
