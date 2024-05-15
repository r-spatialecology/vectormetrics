testthat::test_that("check get_circum_diam value", {
  expect_equal(get_circum_diam(square, "class")$value, 1.41, tolerance = 0.01)
  expect_equal(get_circum_diam(diamond, "class")$value, 8, tolerance = 0.01)
  expect_equal(get_circum_diam(circle, "class")$value, 2)
})

testthat::test_that("check get_circum_diam result assertions", {
  expect_error(get_circum_diam(vector_patches |> sf::st_centroid(), "class"))
})

testthat::test_that("check get_circum_diam result structure", {
  expect_s3_class(get_circum_diam(square, "class"), "tbl_df")
  expect_equal(ncol(get_circum_diam(square, "class")), 5)
  expect_equal(nrow(get_circum_diam(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(get_circum_diam(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(get_circum_diam(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(get_circum_diam(vector_patches, "class", "patch"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(get_circum_diam(square, "class")$class, "character")
  expect_type(get_circum_diam(square, "class")$id, "character")
  expect_type(get_circum_diam(square, "class")$value, "double")
})
