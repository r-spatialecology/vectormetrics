diameter = vm_p_circum(square, "class")$value

testthat::test_that("check vm_p_circum value", {
  expect_equal(diameter, 1.41, tolerance = 0.01)
})
