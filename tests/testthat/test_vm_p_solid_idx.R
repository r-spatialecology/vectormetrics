testthat::test_that("check vm_p_circum value", {
  expect_equal(vm_p_solid_idx(square, "class")$value, 1, tolerance = 0.01)
  expect_equal(vm_p_solid_idx(circle, "class")$value, 1, tolerance = 0.01)
  expect_equal(vm_p_solid_idx(diamond, "class")$value, 1)
})
