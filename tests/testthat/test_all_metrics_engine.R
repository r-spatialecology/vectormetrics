# Minimal test engine for all vectormetrics metrics
# Uses vm_metrics metadata to systematically test all 138 functions

# Metrics requiring multiclass test data (clc_sample instead of vector_patches).
# Diversity, evenness, and richness metrics (shdi, shei, sidi, siei, msidi, msiei, pr, rpr)
# need many classes to produce meaningful results. enn and proxim metrics also use
# clc_sample due to its more realistic spatial configuration.
MULTICLASS_METRICS <- c("enn", "proxim", "msidi", "msiei", "sidi", "siei", "shdi", "shei", "rpr", "^vm_l_pr$")

testthat::test_that("All metric functions return correct structure", {
  for (i in seq_len(nrow(vm_metrics))) {
    fn_name <- vm_metrics$function_name[i]
    level <- vm_metrics$level[i]
    
    # Check function exists
    if (!exists(fn_name, mode = "function")) {
      testthat::fail(paste0(fn_name, ": Function not found"))
      next
    }
    
    fn <- get(fn_name, mode = "function")
    
    # Determine if using clc_sample or vector_patches
    uses_clc <- any(vapply(MULTICLASS_METRICS, grepl, logical(1), fn_name))
    test_data <- if (uses_clc) clc_sample else vector_patches
    test_class <- if ("CODE_18" %in% names(test_data)) "CODE_18" else "class"
    
    # Determine expected rows based on test data
    expected_rows <- switch(level,
      patch = nrow(test_data),
      class = length(unique(test_data[[test_class]])),
      landscape = 1
    )
    
    # Build arguments based on function signature
    args <- formals(fn)
    needs_edge <- "edge_depth" %in% names(args)
    needs_class <- "class_col" %in% names(args)
    needs_class_max <- "class_max" %in% names(args)
    
    call_args <- list(test_data)
    if (needs_class) call_args <- c(call_args, class_col = test_class)
    if (level == "patch" && !needs_class) call_args <- c(call_args, test_class, "patch")
    if (level == "class" && !needs_class) call_args <- c(call_args, test_class)
    if (needs_edge) call_args <- c(call_args, edge_depth = 1)
    if (needs_class_max) call_args <- c(call_args, class_max = 50)
    
    # Special handling for proximity (needs n parameter)
    if (grepl("proxim", fn_name)) {
      call_args <- c(call_args, n = 50)
    }
    
    # Run function and validate
    result <- tryCatch(
      do.call(fn, call_args),
      error = function(e) NULL
    )
    
    if (is.null(result)) {
      testthat::fail(paste0(fn_name, ": Error during execution"))
      next
    }
    
    # Validate structure
    testthat::expect_true(inherits(result, "tbl_df"), info = fn_name)
    testthat::expect_true(
      all(c("level", "class", "id", "metric", "value") %in% names(result)),
      info = fn_name
    )
    testthat::expect_true(all(result$level == level), info = fn_name)
    testthat::expect_type(result$level, "character")
    testthat::expect_type(result$metric, "character")
    testthat::expect_true(is.numeric(result$value), info = fn_name)
    # Allow NA, finite, or infinite values (some metrics can legitimately be Inf)
    testthat::expect_true(
      all(is.na(result$value) | is.finite(result$value) | is.infinite(result$value)),
      info = fn_name
    )
    testthat::expect_equal(nrow(result), expected_rows, info = fn_name)
  }
})

