#' List available metrics in vectormetrics
#'
#' Returns a tibble with information about all available metrics in the
#' vectormetrics package.
#'
#' @param level Optional. Character vector of levels to include. One or more of
#'   `"patch"`, `"class"`, or `"landscape"`. If `NULL` (default), all levels are
#'   returned.
#' @param metric Optional. Character vector of metric abbreviations to include
#'   (e.g., `"area"`, `"enn"`). If `NULL` (default), all metrics are returned.
#' @param name Optional. Character vector of metric names to include (e.g.,
#'   `"area"`, `"core area"`). If `NULL` (default), all metrics are returned.
#' @param type Optional. Character vector of metric types to include (e.g.,
#'   `"shape metric"`, `"area and edge metric"`). If `NULL` (default), all types
#'   are returned.
#' @param what Optional. Not used. Included for compatibility with
#'   `landscapemetrics::list_lsm()`.
#'
#' @return A tibble with columns:
#'   \describe{
#'     \item{metric}{Abbreviation of the metric (e.g., `"area"`, `"enn"`)}
#'     \item{name}{Full name of the metric}
#'     \item{type}{Type of metric (e.g., `"shape metric"`, `"aggregation metric"`)}
#'     \item{level}{Level of calculation: `"patch"`, `"class"`, or `"landscape"`}
#'     \item{function_name}{R function name to calculate the metric}
#'   }
#'
#' @examples
#' \dontrun{
#' # List all available metrics
#' list_vm()
#'
#' # List only patch-level metrics
#' list_vm(level = "patch")
#'
#' # List only shape metrics
#' list_vm(type = "shape metric")
#'
#' # List metrics with specific abbreviation
#' list_vm(metric = "area")
#' }
#'
#' @export
list_vm <- function(level = NULL,
                    metric = NULL,
                    name = NULL,
                    type = NULL,
                    what = NULL) {

  result <- vectormetrics::vm_metrics

  # Filter by level
  if (!is.null(level)) {
    result <- result[result$level %in% level, ]
  }

  # Filter by metric (short_name)
  if (!is.null(metric)) {
    result <- result[result$short_name %in% metric, ]
  }

  # Filter by name
  if (!is.null(name)) {
    result <- result[result$name %in% name, ]
  }

  # Filter by type
  if (!is.null(type)) {
    result <- result[result$type %in% type, ]
  }

  # Select and order columns for output
  result <- result[, c("short_name", "name", "type", "level", "function_name")]
  colnames(result)[1] <- "metric"

  return(result)
}
