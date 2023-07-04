axes = get_axes(diamond, "class")

testthat::test_that("check number of patches", {
  expect_equal(axes$major, 4)
  expect_equal(axes$minor, 2)
})
