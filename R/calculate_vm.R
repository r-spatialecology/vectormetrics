#' Calculate multiple vectormetrics at once
#'
#' Wrapper function to calculate selected metrics for vector landscape data.
#'
#' @param landscape sf object with polygon or multipolygon geometry.
#' @param level Optional. Character vector of levels to include. One or more of
#'   `"patch"`, `"class"`, or `"landscape"`. If `NULL` (default), all levels are
#'   returned based on other arguments.
#' @param metric Optional. Character vector of metric abbreviations to include
#'   (e.g., `"area"`, `"enn"`). If `NULL` (default), all metrics are returned
#'   based on other arguments.
#' @param type Optional. Character vector of metric types to include (e.g.,
#'   `"shape metric"`, `"area and edge metric"`). If `NULL` (default), all types
#'   are returned based on other arguments.
#' @param what Optional. Character vector of function names to use (e.g.,
#'   `c("vm_p_area", "vm_c_ca")`). If specified, this overrides `level`,
#'   `metric`, and `type` arguments.
#' @param class_col Optional. The name of the class column in the landscape.
#'   Required for class-level metrics.
#' @param patch_col Optional. The name of the patch ID column. If `NULL`,
#'   patch IDs are generated automatically.
#' @param verbose Logical. Print warning messages. Default: `TRUE`.
#' @param ... Additional arguments passed to metric functions (e.g.,
#'   `edge_depth = 0.8` for core area metrics).
#'
#' @return A tibble with columns: `level`, `class`, `id`, `metric`, and `value`.
#'
#' @examples
#' \dontrun{
#' # Calculate patch-level metrics
#' # Note: edge_depth is needed for core area metrics (cai, core, ncore)
#' calculate_vm(vector_patches, level = "patch", edge_depth = 0.8)
#'
#' # Calculate specific metrics by abbreviation (no additional arguments needed)
#' calculate_vm(vector_patches, metric = c("area", "perim"))
#'
#' # Calculate specific functions
#' calculate_vm(vector_patches, what = c("vm_p_area", "vm_p_perim"))
#'
#' # Calculate class-level metrics (requires class_col)
#' calculate_vm(vector_landscape, what = "vm_c_ca", class_col = "class")
#'
#' # Calculate landscape-level metrics (some require class_col and edge_depth)
#' calculate_vm(vector_landscape, level = "landscape", class_col = "class",
#'              edge_depth = 0.8, class_max = 10)
#' }
#'
#' @export
calculate_vm <- function(landscape,
                         level = NULL,
                         metric = NULL,
                         type = NULL,
                         what = NULL,
                         class_col = NULL,
                         patch_col = NULL,
                         verbose = TRUE,
                         ...) {

  # Get list of functions to call
  if (!is.null(what)) {
    # Use specified functions directly
    functions_to_call <- what
  } else {
    # Get functions based on filters
    metrics_list <- list_vm(level = level, metric = metric, type = type)
    functions_to_call <- unique(metrics_list$function_name)
  }

  if (length(functions_to_call) == 0) {
    if (verbose) {
      rlang::warn("No metrics selected. Check your input arguments.")
    }
    return(NULL)
  }

  # Prepare arguments for each function
  func_args <- list(landscape = landscape)
  if (!is.null(class_col)) {
    func_args$class_col <- class_col
  }
  if (!is.null(patch_col)) {
    func_args$patch_col <- patch_col
  }

  # Add additional arguments from ...
  additional_args <- list(...)
  if (length(additional_args) > 0) {
    func_args <- c(func_args, additional_args)
  }

  # Calculate all metrics
  results <- lapply(functions_to_call, function(func_name) {
    # Get the function
    func <- tryCatch(
      get(func_name, mode = "function", envir = asNamespace("vectormetrics")),
      error = function(e) {
        if (verbose) {
          rlang::warn(paste("Function not found:", func_name))
        }
        return(NULL)
      }
    )
    
    if (is.null(func)) return(NULL)

    # Filter arguments to only those accepted by this function
    func_formals <- names(formals(func))
    call_args <- func_args[names(func_args) %in% func_formals]

    # Try to call the function
    tryCatch(
      do.call(func, call_args),
      error = function(e) {
        if (verbose) {
          rlang::warn(paste("Error calculating", func_name, ":", e$message))
        }
        NULL
      }
    )
  })


  # Combine non-NULL results
  combined_results <- results[!vapply(results, is.null, logical(1))] |>
    dplyr::bind_rows()

  combined_results
}
