sq_comp = vm_p_comp_idx(square, "class")$value
cir_comp = vm_p_comp_idx(circle, "class")$value
diam_comp = vm_p_comp_idx(diamond, "class")$value

testthat::test_that("check vm_p_circum value", {
  expect_equal(sq_comp, 0.7853, tolerance = 0.001)
  expect_equal(diam_comp, 0.628, tolerance = 0.001)
  expect_equal(cir_comp, 1, tolerance = 0.001)
})
