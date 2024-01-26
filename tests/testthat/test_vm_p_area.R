testthat::test_that("check vm_p_area value", {
  expect_equal(vm_p_area(square, "class")$value * 10000, 1)
  expect_equal(vm_p_area(diamond, "class")$value * 10000, 16)
  expect_equal(vm_p_area(circle, "class")$value * 10000, 3.14, tolerance = 0.001)
})
