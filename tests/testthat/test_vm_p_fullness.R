testthat::test_that("check vm_p_fullness value", {
  sf::st_agr(diamond) <- "constant"
  expect_equal(vm_p_fullness(square, "class", n = 10000)$value, 1, tolerance = 0.015)
  expect_equal(vm_p_fullness(diamond, "class", n = 10000)$value, 1, tolerance = 0.015)
  expect_equal(vm_p_fullness(circle, "class", n = 10000)$value, 1, tolerance = 0.015)
  expect_equal(vm_p_fullness(sf::st_difference(diamond, diamond |> sf::st_centroid() |> sf::st_buffer(1.5)), "class", n = 10000)$value, 0.93, tolerance = 0.01)
})

testthat::test_that("check vm_p_fullness result assertions", {
  sf::st_agr(vector_landscape) <- "constant"
  expect_error(vm_p_fullness(vector_landscape |> sf::st_centroid(), "class"))
  expect_warning(vm_p_fullness(vector_landscape, "class", n = 100), "Low number of local neighbourhoods, result might be biased.")
})

testthat::test_that("check vm_p_fullness result structure", {
  expect_s3_class(vm_p_fullness(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_fullness(square, "class")), 5)
  expect_equal(nrow(vm_p_fullness(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_fullness(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_fullness(vector_patches, "class", "patch"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_fullness(vector_patches, "class", "patch"), by = c("patch" = "id")) |>
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_fullness(square, "class")$class, "character")
  expect_type(vm_p_fullness(square, "class")$id, "character")
  expect_type(vm_p_fullness(square, "class")$value, "double")
})
