testthat::test_that("check vm_p_sph value", {
  expect_equal(vm_p_sph(square, "class")$value, 0.707, tolerance = 0.001)
  expect_equal(vm_p_sph(diamond, "class")$value, 0.447, tolerance = 0.001)
  # expect_equal(vm_p_sph(circle, "class")$value, 1, tolerance = 0.001)
})

testthat::test_that("check vm_p_sph result assertions", {
  expect_error(vm_p_sph(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_p_sph(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_p_sph result structure", {
  expect_s3_class(vm_p_sph(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_sph(square, "class")), 5)
  expect_equal(nrow(vm_p_sph(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_sph(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_sph(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_sph(vector_patches, "class", "patch"), by = c("patch" = "id")) |>
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_sph(square, "class")$class, "character")
  expect_type(vm_p_sph(square, "class")$id, "character")
  expect_type(vm_p_sph(square, "class")$value, "double")
})
