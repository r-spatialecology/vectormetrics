testthat::test_that("check vm_p_girth value", {
  expect_equal(vm_p_girth(square, "class")$value, 0.886, tolerance = 0.001)
  expect_equal(vm_p_girth(diamond, "class")$value, 0.792, tolerance = 0.001)
  expect_equal(vm_p_girth(circle, "class")$value, 1, tolerance = 0.001)
})

testthat::test_that("check vm_p_girth result assertions", {
  expect_error(vm_p_girth(vector_patches |> sf::st_centroid(), "class"))
})

testthat::test_that("check vm_p_girth result structure", {
  expect_s3_class(vm_p_girth(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_girth(square, "class")), 5)
  expect_equal(nrow(vm_p_girth(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_girth(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_girth(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_girth(vector_patches, "class", "patch"), by = c("patch" = "id")) |>
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_girth(square, "class")$class, "character")
  expect_type(vm_p_girth(square, "class")$id, "character")
  expect_type(vm_p_girth(square, "class")$value, "double")
})
