testthat::test_that("check vm_p_elong_idx value", {
  expect_equal(vm_p_elong_idx(square, "class")$value, 0)
  expect_equal(vm_p_elong_idx(diamond, "class")$value, 0.5)
  expect_equal(vm_p_elong_idx(circle, "class")$value, 0)
})