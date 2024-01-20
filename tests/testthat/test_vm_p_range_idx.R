sq_range = vm_p_range_idx(square, "class")$value
cir_range = vm_p_range_idx(circle, "class")$value
diam_range = vm_p_range_idx(diamond, "class")$value
sqtxt_range = vm_p_range_idx(squaretxt, "class")

testthat::test_that("check vm_p_range_idx value", {
  expect_equal(sq_range, 0.7978, tolerance = 0.001)
  expect_equal(diam_range, 0.564, tolerance = 0.001)
  expect_equal(cir_range, 1, tolerance = 0.001)
  expect_true(!is.na(sqtxt_range$class))
})
