testthat::test_that("check vm_p_circum value", {
  expect_equal(vm_p_circ_idx(square, "class")$value, 0.787, tolerance = 0.01)
  expect_equal(vm_p_circ_idx(diamond, "class")$value, 0.628, tolerance = 0.01)
  expect_equal(vm_p_circ_idx(circle, "class")$value, 1, tolerance = 0.01)
})
