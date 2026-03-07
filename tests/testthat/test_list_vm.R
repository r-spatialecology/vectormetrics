test_that("list_vm returns tibble with correct structure", {
  result <- list_vm()

  expect_s3_class(result, "tbl_df")
  expect_s3_class(result, "data.frame")

  expected_cols <- c("metric", "name", "type", "level", "function_name")
  expect_equal(colnames(result), expected_cols)
})

test_that("list_vm filters by level correctly", {
  patch_result <- list_vm(level = "patch")
  expect_true(all(patch_result$level == "patch"))
  expect_gt(nrow(patch_result), 0)

  multi_level_result <- list_vm(level = c("class", "landscape"))
  expect_true(all(multi_level_result$level %in% c("class", "landscape")))
})

