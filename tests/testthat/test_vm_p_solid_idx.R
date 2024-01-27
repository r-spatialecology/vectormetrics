testthat::test_that("check vm_p_circum value", {
  expect_equal(vm_p_solid_idx(square, "class")$value, 1, tolerance = 0.01)
  expect_equal(vm_p_solid_idx(circle, "class")$value, 1, tolerance = 0.01)
  expect_equal(vm_p_solid_idx(diamond, "class")$value, 1)
})

testthat::test_that("check vm_p_circum result assertions", {
  expect_error(vm_p_circum(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_p_circum(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_p_circum result structure", {
  expect_s3_class(vm_p_circum(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_circum(square, "class")), 5)
  expect_equal(nrow(vm_p_circum(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_circum(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_circum(vector_patches, "class"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_circum(vector_patches, "class"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_circum(square, "class")$value, "double")
})
