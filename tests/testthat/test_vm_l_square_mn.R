testthat::test_that("check vm_l_square_mn value", {
  expect_equal(vm_l_square_mn(square |> rbind(circle) |> rbind(diamond))$value, 1.007, tolerance = 0.001)
})

testthat::test_that("check vm_l_square_mn result assertions", {
  expect_error(vm_l_square_mn(vector_patches |> sf::st_centroid()))
  expect_message(vm_l_square_mn(vector_landscape), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_l_square_mn result structure", {
  expect_s3_class(vm_l_square_mn(square), "tbl_df")
  expect_equal(ncol(vm_l_square_mn(square)), 5)
  expect_equal(nrow(vm_l_square_mn(vector_patches)), 1)
  expect_true(is.na(vm_l_square_mn(squaretxt)$class))
  expect_true(is.na(vm_l_square_mn(squaretxt)$id))
  expect_type(vm_l_square_mn(square)$value, "double")
})