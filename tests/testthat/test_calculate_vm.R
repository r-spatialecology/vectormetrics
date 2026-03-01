test_that("calculate_vm returns tibble with correct structure", {
  skip_if_not(exists("vector_patches"))

  result <- calculate_vm(vector_patches, level = "patch", metric = "area")

  expect_s3_class(result, "tbl_df")
  expect_s3_class(result, "data.frame")

  expected_cols <- c("level", "class", "id", "metric", "value")
  expect_equal(colnames(result), expected_cols)
})

test_that("calculate_vm filters by level correctly", {
  skip_if_not(exists("vector_patches"))

  patch_result <- calculate_vm(vector_patches, level = "patch", metric = "area")
  expect_true(all(patch_result$level == "patch"))
  expect_gt(nrow(patch_result), 0)
})

test_that("calculate_vm filters by metric correctly", {
  skip_if_not(exists("vector_patches"))

  area_result <- calculate_vm(vector_patches, metric = "area")
  expect_true(all(area_result$metric == "area"))

  multi_result <- calculate_vm(vector_patches, metric = c("area", "perim"))
  expect_true(all(multi_result$metric %in% c("area", "perim")))
})

test_that("calculate_vm passes additional arguments", {
  skip_if_not(exists("vector_patches"))

  result <- calculate_vm(vector_patches, metric = "cai", edge_depth = 0.8)
  expect_true(all(result$metric == "cai"))
  expect_gt(nrow(result), 0)
})

test_that("calculate_vm with what argument", {
  skip_if_not(exists("vector_patches"))

  result <- calculate_vm(vector_patches, what = c("vm_p_area", "vm_p_perim"))
  expect_true(all(result$metric %in% c("area", "perim")))
})
