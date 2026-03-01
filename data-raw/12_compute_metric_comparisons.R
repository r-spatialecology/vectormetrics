# Compute metrics from vectormetrics and landscapemetrics and compare them
# Uses metric_map output from 11_build_metric_map.R
# Produces comparison_results.rds with raw metric values and differences

library(dplyr)
library(tidyr)
library(tibble)
library(sf)
library(terra)

# ============================================================
# Load metric_map from script 11
# ============================================================
metric_map <- source("data-raw/11_build_metric_map.R")$value

# Restrict to common metrics (present in both packages)
metric_map <- metric_map |> filter(!is.na(vm_fun) & !is.na(lsm_fun))

# ============================================================
# Create comparable landscapes: raster and polygon versions
# ============================================================
create_landscapes <- function() {
  raster_landscape <- landscapemetrics::landscape |> terra::rast()
  polygon_landscape <- raster_landscape |>
    terra::as.polygons(dissolve = TRUE) |>
    sf::st_as_sf() |>
    dplyr::rename(class = clumps) |>
    vectormetrics::get_patches("class", direction = 8) |>
    sf::st_set_crs("EPSG:2180")
  list(raster = raster_landscape, polygon = polygon_landscape)
}

# ============================================================
# Configuration: sensible defaults
# ============================================================
EDGE_DEPTH_DEFAULT <- 1
CLASS_MAX_DEFAULT <- 3

# ============================================================
# Extract standardized columns from metric outputs
# Both packages return tibbles with: level, class, id, metric, value
# (landscapemetrics adds a 'layer' column which we ignore)
# ============================================================
.extract_values <- function(df) {
  # Select and rename columns for consistency
  df |>
    dplyr::select(class, id, value) |>
    dplyr::rename(patch_id = id) |>
    dplyr::mutate(patch_id = as.character(patch_id), class = as.character(class))
}

# ============================================================
# Run metric function with standard arguments
# Both packages have stable signatures; vectormetrics uses
# (landscape, class_col, patch_col), landscapemetrics uses (landscape)
# ============================================================
run_metric <- function(pkg, fn_name, obj, class_col = NULL) {
  if (is.na(fn_name) || fn_name == "") return(NULL)
  
  fn <- getExportedValue(pkg, fn_name)
  fn_args <- names(formals(fn))
  
  tryCatch({
    result <- if (pkg == "vectormetrics") {
      # Build arguments list only with parameters the function supports
      call_args <- list(obj)
      if ("class_col" %in% fn_args && !is.null(class_col)) {
        call_args$class_col <- class_col
      }
      if ("patch_col" %in% fn_args) {
        call_args$patch_col <- "patch"
      }
      if ("edge_depth" %in% fn_args) {
        call_args$edge_depth <- EDGE_DEPTH_DEFAULT
      }
      if ("classes_max" %in% fn_args) {
        call_args$classes_max <- CLASS_MAX_DEFAULT
      }
      do.call(fn, call_args)
    } else {
      # landscapemetrics: also pass class_max where needed (e.g., for RPR)
      call_args <- list(obj)
      if ("classes_max" %in% fn_args) {
        call_args$classes_max <- CLASS_MAX_DEFAULT
      }
      do.call(fn, call_args)
    }
    result |> .extract_values()
  }, error = function(e) {
    rlang::warn(paste("Metric", fn_name, "failed:", e$message))
    NULL
  })
}

# ============================================================
# Run metric comparisons
# ============================================================
landscapes <- create_landscapes()
rast <- landscapes$raster
patches_sf <- landscapes$polygon

# Calculate metrics for all common functions
comparison_results <- metric_map |> 
  rowwise() |> 
  mutate(
  base_name = sub("^[pcl]_", "", metric_name),
  
  # Run each metric function
  vm_res = list(run_metric("vectormetrics", vm_fun, patches_sf, class_col = "class")),
  lsm_res = list(run_metric("landscapemetrics", lsm_fun, rast)),
  
  # Compare results
  comparison = list({   
    # If either is NULL (metric failed), skip comparison
    if (is.null(vm_res) || is.null(lsm_res)) {
      tibble()
    } else {
      # Join and compute differences
      dplyr::full_join(vm_res, lsm_res, by = c("patch_id", "class"), suffix = c("_vm", "_lsm")) |>
        dplyr::mutate(abs_diff = abs(value_vm - value_lsm))
    }
  })
)

# ============================================================
# Unnest and organize by level
# ============================================================
raw_comparison <- comparison_results |> 
  tidyr::unnest(comparison, keep_empty = TRUE) |>
  dplyr::select(metric_name, vm_fun, lsm_fun, level, base_name, 
                patch_id, class, value_vm, value_lsm, abs_diff)

# Split by level
comparison_l <- raw_comparison |> filter(level == "landscape")
comparison_c <- raw_comparison |> filter(level == "class")

# For patch level, aggregate by class (inconsistent patch IDs between tools)
# Note: Patch IDs differ between vectormetrics and landscapemetrics,
# so we compute mean values across patches within each class. The n_patches columns indicate
# potential patch count discrepancies; large differences suggest rasterization effects.
comparison_p <- raw_comparison |> 
  filter(level == "patch") |>
  group_by(metric_name, vm_fun, lsm_fun, level, base_name, class) |>
  summarise(
    n_patches_vm = sum(!is.na(value_vm)),
    n_patches_lsm = sum(!is.na(value_lsm)),
    value_vm = mean(value_vm, na.rm = TRUE),
    value_lsm = mean(value_lsm, na.rm = TRUE),
    abs_diff = abs(value_vm - value_lsm),
    patch_count_mismatch = n_patches_vm != n_patches_lsm,
    .groups = "drop"
  )

# ============================================================
# Save raw comparison results
# ============================================================
comparison_results <- structure(
  list(
    all = raw_comparison,
    landscape = comparison_l,
    class = comparison_c,
    patch = comparison_p
  ),
  class = c("metric_comparison", "list"),
  meta = list(
    n_metrics = nrow(metric_map),
    timestamp = Sys.time(),
    note = "Raw metric values with differences; patch-level metrics are aggregated by class"
  )
)

# Save to inst/extdata (supplementary data files, not official package data)
dir.create("inst/extdata", showWarnings = FALSE, recursive = TRUE)
saveRDS(comparison_results, "inst/extdata/vm_lsm_baseline.rds")
saveRDS(patches_sf, "inst/extdata/landscape_polygons.rds")

cat("\nResults saved to: inst/extdata/vm_lsm_baseline.rds\n")
cat("Test landscape saved to: inst/extdata/landscape_polygons.rds\n")

