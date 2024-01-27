testthat::test_that("check vm_p_area value", {
  expect_equal(vm_p_area(square, "class")$value * 10000, 1)
  expect_equal(vm_p_area(diamond, "class")$value * 10000, 16)
  expect_equal(vm_p_area(circle, "class")$value * 10000, 3.14, tolerance = 0.001)
})

testthat::test_that("check vm_p_area result assertions", {
  expect_error(vm_p_area(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_p_area(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_p_area result structure", {
  expect_s3_class(vm_p_area(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_area(square, "class")), 5)
  expect_equal(nrow(vm_p_area(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_area(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_area(vector_patches, "class"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_area(vector_patches, "class"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_area(square, "class")$value, "double")
})
