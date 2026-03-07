#' Build a mapping of vectormetrics and landscapemetrics functions with level-prefixed metric names
#'
#' This script discovers all metric functions in vectormetrics and landscapemetrics,
#' identifies matching pairs (same metric name across packages), and constructs a clean
#' tibble with level-prefixed metric names for comparison work.
#'
#' Output: A tibble with columns:
#'   - metric_name: Level-prefixed metric name (e.g., "l_ta", "c_te", "p_shape")
#'   - vm_fun: vectormetrics function name (e.g., "vm_l_ta")
#'   - lsm_fun: landscapemetrics function name (e.g., "lsm_l_ta"), or NA if no match
#'   - level: Metric level ("landscape", "class", or "patch")

library(dplyr)
library(tibble)

# ============================================================
# Helper: Find exported functions matching a pattern
# ============================================================

.find_exports <- function(pkg, pattern) {
  if (!requireNamespace(pkg, quietly = TRUE)) return(character(0))
  exports <- getNamespaceExports(pkg)
  exports[grepl(pattern, exports)]
}

# ============================================================
# Main: Build metric_map
# ============================================================

# Discover all metric functions from both packages
vm_fns <- .find_exports("vectormetrics", "^vm_[pcl]_")
lsm_fns <- .find_exports("landscapemetrics", "^lsm_[pcl]_")

# Create tibble with all vm functions
# vm_[p/c/l]_metric -> level_code at position 4
vm_tbl <- tibble(vm_fun = vm_fns) |>
  mutate(
    level_code = substr(vm_fun, 4, 4),
    base_metric = sub("^vm_[pcl]_", "", vm_fun)
  )

# Create tibble with all lsm functions
# lsm_[p/c/l]_metric -> level_code at position 5
lsm_tbl <- tibble(lsm_fun = lsm_fns) |>
  mutate(
    level_code = substr(lsm_fun, 5, 5),
    base_metric = sub("^lsm_[pcl]_", "", lsm_fun)
  )

# Join by level_code + base_metric (this matches vm_l_ta with lsm_l_ta, not with lsm_c_ta)
metric_map <- vm_tbl |>
  full_join(lsm_tbl, by = c("level_code", "base_metric"), relationship = "many-to-one") |>
  mutate(
    level = case_when(
      level_code == "p" ~ "patch",
      level_code == "c" ~ "class",
      level_code == "l" ~ "landscape",
      TRUE ~ NA_character_
    ),
    metric_name = paste0(level_code, "_", base_metric)
  ) |>
  select(metric_name, vm_fun, lsm_fun, level) |>
  arrange(metric_name)

# Return the tibble
metric_map
