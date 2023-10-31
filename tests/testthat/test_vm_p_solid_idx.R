sq_solidity = vm_p_solid_idx(square, "class")$value
cir_solidity = vm_p_solid_idx(circle, "class")$value
diam_solidity = vm_p_solid_idx(diamond, "class")$value

testthat::test_that("check vm_p_circum value", {
  expect_equal(sq_solidity, 1, tolerance = 0.01)
  expect_equal(diam_solidity, 1, tolerance = 0.01)
  expect_equal(cir_solidity, 1)
})
