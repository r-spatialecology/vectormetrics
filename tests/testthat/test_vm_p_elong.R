testthat::test_that("check vm_p_elong value", {
  expect_equal(vm_p_elong(square, "class")$value, 0)
  expect_equal(vm_p_elong(diamond, "class")$value, 0.5)
  expect_equal(vm_p_elong(circle, "class")$value, 0)
})

testthat::test_that("check vm_p_elong result assertions", {
  expect_error(vm_p_elong(vector_patches |> sf::st_centroid(), "class"))
})

testthat::test_that("check vm_p_elong result structure", {
  expect_s3_class(vm_p_elong(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_elong(square, "class")), 5)
  expect_equal(nrow(vm_p_elong(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_elong(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_elong(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_elong(vector_patches, "class", "patch"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_elong(square, "class")$class, "character")
  expect_type(vm_p_elong(square, "class")$id, "character")
  expect_type(vm_p_elong(square, "class")$value, "double")
})