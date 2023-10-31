sq_area = vm_p_area(square, "class")$value * 10000
diam_area = vm_p_area(diamond, "class")$value * 10000
cir_area = vm_p_area(circle, "class")$value * 10000

testthat::test_that("check vm_p_area value", {
  expect_equal(sq_area, 1)
  expect_equal(diam_area, 16)
  expect_equal(cir_area, 3.14, tolerance = 0.001)
})
