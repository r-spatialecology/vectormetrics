testthat::test_that("check vm_p_perim value", {
  expect_equal(vm_p_perim(square, "class")$value, 4, tolerance = 0.01)
  expect_equal(vm_p_perim(diamond, "class")$value, 17.888, tolerance = 0.01)
  expect_equal(vm_p_perim(circle, "class")$value, 6.283, tolerance = 0.01)
})

testthat::test_that("check vm_p_perim result assertions", {
  expect_error(vm_p_perim(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_p_perim(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_p_perim result structure", {
  expect_s3_class(vm_p_perim(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_perim(square, "class")), 5)
  expect_equal(nrow(vm_p_perim(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_perim(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_perim(vector_patches, "class"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_perim(vector_patches, "class"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_perim(square, "class")$value, "double")
})