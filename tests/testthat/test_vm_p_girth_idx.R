sq_girth = vm_p_girth_idx(square, "class")$value
diam_girth = vm_p_girth_idx(diamond, "class")$value
cir_girth = vm_p_girth_idx(circle, "class")$value

testthat::test_that("check vm_p_girth_idx value", {
  expect_equal(sq_girth, 0.886, tolerance = 0.001)
  expect_equal(diam_girth, 0.792, tolerance = 0.001)
  expect_equal(cir_girth, 1, tolerance = 0.001)
})