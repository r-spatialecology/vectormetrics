testthat::test_that("check vm_l_area_mn value", {
  expect_equal(vm_l_area_mn(square |> rbind(circle) |> rbind(diamond), "class")$value, 6.713, tolerance = 0.001)
})

testthat::test_that("check vm_l_area_mn result assertions", {
  expect_error(vm_l_area_mn(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_l_area_mn(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_l_area_mn result structure", {
  expect_s3_class(vm_l_area_mn(square, "class"), "tbl_df")
  expect_equal(ncol(vm_l_area_mn(square, "class")), 5)
  expect_equal(nrow(vm_l_area_mn(vector_patches, "class")), 1)
  expect_true(is.na(vm_l_area_mn(squaretxt, "class")$class))
  expect_true(is.na(vm_l_area_mn(squaretxt, "class")$id))
  expect_type(vm_l_area_mn(square, "class")$value, "double")
})