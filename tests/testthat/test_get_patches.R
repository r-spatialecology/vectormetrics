patches4 = get_patches(vector_landscape, "class", 4)
patches8 = get_patches(vector_landscape, "class", 8)

testthat::test_that("test testu", {
  expect_equal(nrow(patches4), 35)
  expect_equal(nrow(patches8), 27)
})
