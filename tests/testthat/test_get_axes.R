testthat::test_that("check get_axes value", {
  expect_equal(get_axes(square, "class")$major, 1.42, tolerance = 0.001)
  expect_equal(get_axes(square, "class")$minor, 1.42, tolerance = 0.001)
  expect_equal(get_axes(diamond, "class")$major, 8, tolerance = 0.001)
  expect_equal(get_axes(diamond, "class")$minor, 4, tolerance = 0.001)
  expect_equal(get_axes(circle, "class")$major, 2, tolerance = 0.001)
  expect_equal(get_axes(circle, "class")$minor, 2, tolerance = 0.001)
})

testthat::test_that("check get_axes result assertions", {
  expect_error(get_axes(vector_patches |> sf::st_centroid(), "class"))
  expect_message(get_axes(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check get_axes result structure", {
  expect_s3_class(get_axes(square, "class"), "tbl_df")
  expect_equal(ncol(get_axes(square, "class")), 6)
  expect_equal(nrow(get_axes(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(get_axes(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(get_axes(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(get_axes(vector_patches, "class", "patch"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(get_axes(square, "class")$class, "character")
  expect_type(get_axes(square, "class")$id, "character")
  expect_type(get_axes(square, "class")$major, "double")
  expect_type(get_axes(square, "class")$minor, "double")
})
