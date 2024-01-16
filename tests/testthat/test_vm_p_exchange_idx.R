sq_exchange = vm_p_exchange_idx(square, "class")$value
diam_exchange = vm_p_exchange_idx(diamond, "class")$value
cir_exchange = vm_p_exchange_idx(circle, "class")$value

testthat::test_that("check vm_p_exchange_idx value", {
  expect_equal(sq_exchange, 0.91, tolerance = 0.001)
  expect_equal(diam_exchange, 0.795, tolerance = 0.001)
  expect_equal(cir_exchange, 1, tolerance = 0.001)
})