test_that("class-level metrics preserve first-occurrence class order", {
  original_classes <- unique(as.character(vector_patches$class))
  replacement_classes <- c("10", "2", "1")[seq_along(original_classes)]
  class_map <- stats::setNames(replacement_classes, original_classes)

  landscape <- vector_patches
  landscape$class <- unname(class_map[as.character(landscape$class)])
  expected_classes <- replacement_classes

  class_functions <- vm_metrics$function_name[vm_metrics$level == "class"]

  for (fn_name in class_functions) {
    fn <- get(fn_name, mode = "function")
    fn_args <- names(formals(fn))
    call_args <- list(landscape)

    if ("class_col" %in% fn_args) call_args$class_col <- "class"
    if ("edge_depth" %in% fn_args) call_args$edge_depth <- 1
    if ("classes_max" %in% fn_args) call_args$classes_max <- 50
    if ("n" %in% fn_args) call_args$n <- 10
    if ("progress" %in% fn_args) call_args$progress <- FALSE

    result <- suppressWarnings(do.call(fn, call_args))

    expect_identical(
      as.character(result$class),
      expected_classes,
      info = paste("Unexpected class order from", fn_name)
    )
  }
})
