sq_diameter = vm_p_circum(square, "class")$value
cir_diameter = vm_p_circum(circle, "class")$value
diam_diameter = vm_p_circum(diamond, "class")$value

testthat::test_that("check vm_p_circum value", {
  expect_equal(sq_diameter, 1.41, tolerance = 0.01)
  expect_equal(diam_diameter, 8, tolerance = 0.01)
  expect_equal(cir_diameter, 2)
})
