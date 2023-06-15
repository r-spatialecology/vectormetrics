diameter = vm_p_circum(square, "class")$value
range_index = vm_p_range_idx(square, "class")$value

testthat::test_that("test testu", {
  expect_equal(diameter, 1.41, tolerance = 0.01)
  expect_equal(range_index, 0.7978, tolerance = 0.001)
})
