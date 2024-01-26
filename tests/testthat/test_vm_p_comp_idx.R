testthat::test_that("check vm_p_circum value", {
  expect_equal(vm_p_comp_idx(square, "class")$value, 0.7853, tolerance = 0.001)
  expect_equal(vm_p_comp_idx(diamond, "class")$value, 0.628, tolerance = 0.001)
  expect_equal(vm_p_comp_idx(circle, "class")$value, 1, tolerance = 0.001)
})
