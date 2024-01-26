testthat::test_that("check vm_p_circum value", {
  expect_equal(vm_p_circum(square, "class")$value, 1.41, tolerance = 0.01)
  expect_equal(vm_p_circum(diamond, "class")$value, 8, tolerance = 0.01)
  expect_equal(vm_p_circum(circle, "class")$value, 2)
})
