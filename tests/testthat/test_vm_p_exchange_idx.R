testthat::test_that("check vm_p_exchange_idx value", {
  expect_equal(vm_p_exchange_idx(square, "class")$value, 0.91, tolerance = 0.001)
  expect_equal(vm_p_exchange_idx(diamond, "class")$value, 0.795, tolerance = 0.001)
  expect_equal(vm_p_exchange_idx(circle, "class")$value, 1, tolerance = 0.001)
})