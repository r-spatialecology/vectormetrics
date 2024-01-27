testthat::test_that("check vm_p_exchange_idx value", {
  expect_equal(vm_p_exchange_idx(square, "class")$value, 0.91, tolerance = 0.001)
  expect_equal(vm_p_exchange_idx(diamond, "class")$value, 0.795, tolerance = 0.001)
  expect_equal(vm_p_exchange_idx(circle, "class")$value, 1, tolerance = 0.001)
})

testthat::test_that("check vm_p_exchange_idx result assertions", {
  expect_error(vm_p_exchange_idx(vector_patches |> sf::st_centroid(), "class"))
  expect_message(vm_p_exchange_idx(vector_landscape, "class"), "MULTIPOLYGON geometry provided")
})

testthat::test_that("check vm_p_exchange_idx result structure", {
  expect_s3_class(vm_p_exchange_idx(square, "class"), "tbl_df")
  expect_equal(ncol(vm_p_exchange_idx(square, "class")), 5)
  expect_equal(nrow(vm_p_exchange_idx(vector_patches, "class")), nrow(vector_patches))
  expect_true(!is.na(vm_p_exchange_idx(squaretxt, "class")$class))
  expect_equal(
    nrow(vector_patches |> dplyr::inner_join(vm_p_exchange_idx(vector_patches, "class"), by = c("patch" = "id"))),
    nrow(vector_patches)
  )
  expect_true(all(
    vector_patches |> dplyr::inner_join(vm_p_exchange_idx(vector_patches, "class"), by = c("patch" = "id")) |> 
      dplyr::mutate(same_class = class.x == class.y) |> dplyr::pull(same_class)
  ))
  expect_type(vm_p_exchange_idx(square, "class")$value, "double")
})
