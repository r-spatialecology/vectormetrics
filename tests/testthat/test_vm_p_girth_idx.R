testthat::test_that("check vm_p_girth_idx value", {
  expect_equal(vm_p_girth_idx(square, "class")$value, 0.886, tolerance = 0.001)
  expect_equal(vm_p_girth_idx(diamond, "class")$value, 0.792, tolerance = 0.001)
  expect_equal(vm_p_girth_idx(circle, "class")$value, 1, tolerance = 0.001)
})