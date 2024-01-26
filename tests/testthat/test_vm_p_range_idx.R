testthat::test_that("check vm_p_range_idx value", {
  expect_equal(vm_p_range_idx(square, "class")$value, 0.7978, tolerance = 0.001)
  expect_equal(vm_p_range_idx(diamond, "class")$value, 0.564, tolerance = 0.001)
  expect_equal(vm_p_range_idx(circle, "class")$value, 1, tolerance = 0.001)
  expect_true(!is.na(vm_p_range_idx(squaretxt, "class")$class))
})
