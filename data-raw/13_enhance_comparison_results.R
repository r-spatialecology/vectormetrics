# Enhance comparison results with units and explanations
# Uses comparison_results.rds output from 12_compute_metric_comparisons.R
# Produces enhanced results with vm_units, lsm_units, and diff_explanation
#
# This script focuses on explaining ONLY the metrics that actually differ
# between vectormetrics and landscapemetrics (abs_diff > 0.001)
#
library(dplyr)
library(tidyr)

# ============================================================
# Load raw comparison results from script 12
# ============================================================
comparison_results <- readRDS("inst/extdata/vm_lsm_baseline.rds")

# ============================================================
# Unit definitions for each metric
# ============================================================
get_metric_units <- function(base_name) {
  list(
    vm = dplyr::case_when(
      grepl("_cv$", base_name) ~ "percent (%)",  # Coefficient of variation metrics
      grepl("^cai", base_name) ~ "percent (%)",
      grepl("^ndca", base_name) ~ "count",
      grepl("^pd$|^dcad|^prd", base_name) ~ "count per 100 hectares",
      grepl("^ca$|^ca_", base_name) ~ "hectares",  # Patch class area (tca, ca)
      grepl("^area|^perarea|^ta$|^area_mn|^tca|^core_mn|^dcore_mn|^core_sd|^dcore_sd", base_name) ~ "hectares",
      base_name == "core" ~ "hectares",  # p_core: patch core area
      grepl("^mesh$", base_name) ~ "hectares",
      grepl("^ed$", base_name) ~ "meters per hectare",
      grepl("^enn|^te$|^dist|^perim|^proxim", base_name) ~ "meters",
      grepl("^pland$|^lpi$|^cpland$", base_name) ~ "percent (%)",
      grepl("^pr$|^rpr$", base_name) ~ "percent (%)",
      grepl("^shape|^circle|^frac|^lsi$|^division|^split|^shdi|^shei|^sidi|^siei|^msidi|^msiei|^pafrac", base_name) ~ "index (dimensionless)",
      grepl("^np$|^ncore|^count|^richness", base_name) ~ "count",
      TRUE ~ "varies"
    ),
    lsm = dplyr::case_when(
      grepl("_cv$", base_name) ~ "percent (%)",  # Coefficient of variation metrics
      grepl("^cai", base_name) ~ "percent (%)",
      grepl("^ndca", base_name) ~ "count",
      grepl("^pd$|^dcad|^prd", base_name) ~ "count per 100 hectares",
      grepl("^ca$|^ca_", base_name) ~ "hectares",  # Patch class area (tca, ca)
      grepl("^area|^perarea|^ta$|^area_mn|^tca|^core_mn|^dcore_mn|^core_sd|^dcore_sd", base_name) ~ "hectares",
      base_name == "core" ~ "hectares",  # p_core: patch core area
      grepl("^mesh$", base_name) ~ "hectares",
      grepl("^ed$", base_name) ~ "meters per hectare",
      grepl("^enn|^te$|^dist|^perim|^proxim", base_name) ~ "meters",
      grepl("^pland$|^lpi$|^cpland$", base_name) ~ "percent (%)",
      grepl("^pr$|^rpr$", base_name) ~ "percent (%)",
      grepl("^shape|^circle|^frac|^lsi$|^division|^split|^shdi|^shei|^sidi|^siei|^msidi|^msiei|^pafrac", base_name) ~ "index (dimensionless)",
      grepl("^np$|^ncore|^count|^richness", base_name) ~ "count",
      TRUE ~ "varies"
    )
  )
}

# ============================================================
# Explanations for metrics that differ
# ============================================================
# Based on actual analysis, only 27 metric types show meaningful differences.
metric_explanations <- list(
  # PERIMETER/EDGE METRICS (te, ed, shape, circle, lsi)
  # The key difference: whether landscape boundary is included
  te = "Total edge length. Vector polygons naturally include the landscape boundary as part of their geometry; raster grids typically exclude it. Vectormetrics defaults to including boundaries (count_boundary=TRUE), landscapemetrics excludes them.",
  ed = "Edge density = total edge / area. The difference comes from boundary inclusion: vectormetrics includes the landscape boundary by default, landscapemetrics excludes it.",
  shape = "Shape index compares perimeter to area. Differences can arise from both boundary inclusion and how perimeters are measured (exact polygon edges vs cell-edge counting).",
  shape_mn = "Average patch shape. Differences reflect both boundary inclusion choices and perimeter measurement methods (continuous outlines vs cell edges).",
  shape_sd = "Variation in patch shapes. Reflects differences in boundary inclusion and perimeter measurement approaches.",
  circle = "Related-circumscribing circle = 1 - (patch area / reference area). Standardization differs: vectormetrics uses the smallest circumscribing circle as reference, landscapemetrics uses a circumscribing square. These produce fundamentally different values even for the same patch geometry.",
  circle_mn = "Average circularity. Differs due to standardization choice: vectormetrics standardizes to circles, landscapemetrics to squares. The reference shapes produce different denominators.",
  circle_sd = "Variation in circularity across patches. Reflects the standardization difference between circle (vector) and square (raster) reference shapes.",
  circle_cv = "Relative variation in circularity. Amplifies the standardization differences between circle and square reference geometries.",
  lsi = "Landscape shape index compares total edge to minimum possible. Differs due to boundary inclusion (vectormetrics includes by default, landscapemetrics excludes). Also: vectormetrics standardizes to circles (natural for polygons), landscapemetrics to squares (natural for cells).",
  
  # CORE AREA METRICS (ncore, cai, tca, dcore, dcad, ndca, cpland, core_cv)
  # How cores are identified differs fundamentally
  ncore = "Number of core areas detected. Cores are found differently: vector contracts boundaries inward by a specified distance (in map units), raster excludes edge cells.",
  cai = "Core area index = core area / total area. Cores are detected differently: vector contracts the boundary inward by a specified distance (in map units), raster excludes edge cells.",
  cai_mn = "Average core area ratio. Cores are identified differently: vector shrinks boundaries inward by a specified distance (in map units), raster removes edge cells.",
  cai_sd = "Variation in core ratios. Reflects different core detection: vector contracts boundaries inward (in map units), raster excludes edges.",
  cai_cv = "Relative variation in core ratios. Amplifies differences from contracting boundaries by a distance (vector) vs excluding cells (raster).",
  tca = "Total core area. Combines differences from how cores are found (boundary contraction by distance vs cell exclusion) and how area is measured.",
  dcore_mn = "Average disjunct core size. The methods fragment patches differently: vector contracts boundaries inward by a distance (in map units), raster excludes edge cells.",
  dcore_sd = "Variation in disjunct core sizes. Reflects different fragmentation from boundary contraction by distance (vector) vs edge exclusion (raster).",
  dcore_cv = "Relative variation in core sizes. Amplifies differences from how patches are fragmented into cores.",
  dcad = "Disjunct core area density = cores per 100 hectares. Methods fragment patches differently, creating different numbers of cores.",
  ndca = "Number of disjunct core areas. Methods create different core counts: vector contracts boundaries by a distance (in map units), raster excludes edge cells.",
  cpland = "Core area as percentage of landscape. Differs because cores are identified by different processes.",
  core_cv = "Variation in core sizes. Reflects different identification processes: boundary contraction by distance vs edge cell exclusion.",
  
  # DISTANCE METRICS (enn)
  # Both measure edge-to-edge, but from different reference points
  enn = "Euclidean nearest neighbor distance (edge-to-edge). Both measure to patch edges, but from different reference points: vector measures from exact polygon boundaries, raster measures from cell centers that lie on patch edges (grid-aligned).",
  enn_mn = "Average nearest neighbor distance. Both use edge-to-edge measurement, but edge reference points differ: vector uses exact polygon geometry, raster uses cell centers at patch edges.",
  enn_sd = "Variation in nearest neighbor distances. Reflects different edge reference points: exact polygon boundaries (vector) vs cell-center positions on patch edges (raster).",
  enn_cv = "Relative variation in distances. Amplifies differences from measuring between exact boundaries (vector) vs cell centers at boundaries (raster)."
)

# ============================================================
# Explanation helper - only explain metrics that actually differ
# ============================================================
explain_for_row <- function(metric_name, abs_diff, tolerance = 0.001) {
  # Only provide explanation if there's a meaningful difference
  if (is.na(abs_diff) || abs_diff <= tolerance) {
    return(NA_character_)
  }
  
  # Extract base metric name (remove level prefix)
  base_name <- sub("^[pcl]_", "", as.character(metric_name)[1])
  
  # Return explanation if available
  if (!is.null(metric_explanations[[base_name]])) {
    return(metric_explanations[[base_name]])
  }
  
  # Difference exists but no specific explanation available
  # (This should rarely happen since we only explain metrics that were found to differ)
  return(paste0("Difference detected (", round(abs_diff, 4), ") but no explanation available for metric: ", base_name))
}

# ============================================================
# Enhance results with units and explanations
# ============================================================
# Enhance all results (includes all levels)
enhanced_all <- comparison_results$all |>
  rowwise() |>
  mutate(
    units = list(get_metric_units(base_name)),
    vm_units = units$vm,
    lsm_units = units$lsm,
    diff_explanation = explain_for_row(metric_name, abs_diff)
  ) |>
  ungroup() |>
  select(metric_name, vm_units, lsm_units, vm_fun, lsm_fun, level, base_name,
         patch_id, class, value_vm, value_lsm, abs_diff, diff_explanation)

# Enhance patch-level results (preserves patch_count_mismatch column)
enhanced_patch <- comparison_results$patch |>
  rowwise() |>
  mutate(
    units = list(get_metric_units(base_name)),
    vm_units = units$vm,
    lsm_units = units$lsm,
    diff_explanation = explain_for_row(metric_name, abs_diff)
  ) |>
  ungroup() |>
  select(metric_name, vm_units, lsm_units, vm_fun, lsm_fun, level, base_name,
         class, n_patches_vm, n_patches_lsm, value_vm, value_lsm, abs_diff,
         patch_count_mismatch, diff_explanation)

# Create subsets for convenience
enhanced_results <- structure(
  list(
    all = enhanced_all,
    landscape = enhanced_all |> filter(level == "landscape"),
    class = enhanced_all |> filter(level == "class"),
    patch = enhanced_patch
  ),
  class = c("metric_comparison", "list"),
  meta = list(
    n_metrics = length(unique(enhanced_all$metric_name)),
    n_metrics_with_diffs = sum(!is.na(enhanced_all$diff_explanation)),
    timestamp = Sys.time(),
    note = "Enhanced comparison with units and explanations; only metrics with abs_diff > 0.001 have explanations"
  )
)

# ============================================================
# Load metric_map from script 11
# ============================================================
metric_map <- source("data-raw/11_build_metric_map.R")$value

# ============================================================
# Save both to inst/extdata (supplementary data files)
# ============================================================
dir.create("inst/extdata", showWarnings = FALSE, recursive = TRUE)
comparison_results_enhanced <- enhanced_results
saveRDS(
  list(
    comparison_results_enhanced = comparison_results_enhanced,
    metric_map = metric_map
  ),
  "inst/extdata/vm_lsm_comparison.rds"
)
cat("\nVignette data saved to: inst/extdata/vm_lsm_comparison.rds\n")

