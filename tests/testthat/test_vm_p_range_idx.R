range_index = vm_p_range_idx(square, "class")$value

testthat::test_that("check vm_p_range_idx value", {
  expect_equal(range_index, 0.7978, tolerance = 0.001)
})
