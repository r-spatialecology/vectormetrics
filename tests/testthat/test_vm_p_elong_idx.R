sq_elong = vm_p_elong_idx(square, "class")$value
diam_elong = vm_p_elong_idx(diamond, "class")$value
cir_elong = vm_p_elong_idx(circle, "class")$value

testthat::test_that("check vm_p_elong_idx value", {
  expect_equal(sq_elong, 0)
  expect_equal(diam_elong, 0.5)
  expect_equal(cir_elong, 0)
})