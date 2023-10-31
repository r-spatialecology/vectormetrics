sq_circularity = vm_p_circ_idx(square, "class")$value
cir_circularity = vm_p_circ_idx(circle, "class")$value
diam_circularity = vm_p_circ_idx(diamond, "class")$value

testthat::test_that("check vm_p_circum value", {
  expect_equal(sq_circularity, 0.787, tolerance = 0.01)
  expect_equal(diam_circularity, 0.628, tolerance = 0.01)
  expect_equal(cir_circularity, 1, tolerance = 0.01)
})
