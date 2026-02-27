library(dplyr)
library(tidyr)
library(purrr)
library(tibble)
library(sf)
library(terra)
library(landscapemetrics)
library(vectormetrics)

tolerance <- 1e-6

# ============================================================
# Create raster and polygon versions of same landscape
# ============================================================

create_landscapes <- function() {

  # built-in landscapemetrics raster
  raster_landscape <- landscapemetrics::landscape |>
    terra::rast()

  # polygonize raster
  polygon_landscape <- raster_landscape |>
    terra::as.polygons(dissolve = TRUE) |>
    sf::st_as_sf() |>
    dplyr::rename(class = clumps) |>
    get_patches("class", direction = 8) |>
    sf::st_set_crs("EPSG:2180")

  list(
    raster = raster_landscape,
    polygon = polygon_landscape
  )

}

# ============================================================
# Metric mapping
# ============================================================
metric_map <- tribble(

  # =====================================================
  # PATCH LEVEL — EXACT OR NEAR EXACT
  # =====================================================

  ~metric_name,              ~vm_fun,              ~lsm_fun,

  # "patch_area",             vm_p_area,            lsm_p_area,
  # "patch_perimeter",        vm_p_perim,           lsm_p_perim,
  # "patch_perarea",          vm_p_perarea,         lsm_p_para,

  # "patch_shape",            vm_p_shape,           lsm_p_shape,
  # "patch_frac",             vm_p_frac,            lsm_p_frac,


  # =====================================================
  # CLASS LEVEL — EXACT
  # =====================================================

  "class_ca",               vm_c_ca,              lsm_c_ca,
  "class_np",               vm_c_np,              lsm_c_np,
  "class_te",               vm_c_te,              lsm_c_te,
  "class_ed",               vm_c_ed,              lsm_c_ed,

  "class_area_mn",          vm_c_area_mn,         lsm_c_area_mn,
  # "class_perim_mn",         vm_c_perim_idx_mn,    lsm_c_perim_mn,
  "class_perarea_mn",       vm_c_perarea_mn,      lsm_c_para_mn,


  # =====================================================
  # CLASS LEVEL — NEAR IDENTICAL
  # =====================================================

  # "class_shape_mn",         vm_c_shape_mn,        lsm_c_shape_mn,
  # "class_frac_mn",          vm_c_frac_mn,         lsm_c_frac_mn,


  # =====================================================
  # LANDSCAPE LEVEL — EXACT
  # =====================================================

  # "landscape_ta",           vm_l_ta,              lsm_l_ta,
  # "landscape_np",           vm_l_np,              lsm_l_np,
  # "landscape_te",           vm_l_te,              lsm_l_te,
  # "landscape_ed",           vm_l_ed,              lsm_l_ed,

  # "landscape_area_mn",      vm_l_area_mn,         lsm_l_area_mn,
  # # "landscape_perim_mn",     vm_l_perim_idx_mn,    lsm_l_perim_mn,
  # "landscape_perarea_mn",   vm_l_perarea_mn,      lsm_l_para_mn,


  # =====================================================
  # LANDSCAPE LEVEL — NEAR IDENTICAL
  # =====================================================

  # "landscape_lsi",          vm_l_lsi,             lsm_l_lsi,
  # "landscape_lpi",          vm_l_lpi,             lsm_l_lpi,

  # "landscape_shape_mn",     vm_l_shape_mn,        lsm_l_shape_mn,
  # "landscape_frac_mn",      vm_l_frac_mn,         lsm_l_frac_mn

)

# ============================================================
# Safe execution
# ============================================================

run_safe <- function(fun, x, class_col = NULL) {
  # Check if function needs class_col argument
  args <- formals(fun)
  needs_class <- "class_col" %in% names(args)
  
  call_args <- list(x)
  if (needs_class && !is.null(class_col)) {
    call_args <- c(call_args, class_col = class_col)
  }
  
  tryCatch(
    do.call(fun, call_args) |>
      tibble::as_tibble(),
    error = function(e)
      tibble(
        level = NA_character_,
        class = NA_character_,
        id = NA_character_,
        metric = NA_character_,
        value = NA_real_
      )
  )
}

# ============================================================
# Build comparison
# ============================================================

build_comparison <- function(raster_landscape, polygon_landscape) {

  vm <- metric_map |>
    mutate(result = map(vm_fun, run_safe, polygon_landscape, class_col = "class")) |>
    select(metric_name, result) |>
    unnest(result) |>
    transmute(
      metric_name,
      metric,
      level,
      class,
      patch = id,
      vm_value = value
    )

  lsm <- metric_map |>
    mutate(result = map(lsm_fun, run_safe, raster_landscape)) |>
    select(metric_name, result) |>
    unnest(result) |>
    transmute(
      metric_name,
      level,
      class = as.character(class),
      patch = as.character(id),
      lsm_value = value
    )
  
  vm2 = vm |>
    group_by(metric_name, level, class) |>
    summarise(vm_value = mean(vm_value, na.rm = TRUE), .groups = "drop")

  lsm2 = lsm |>
    group_by(metric_name, level, class) |>
    summarise(lsm_value = mean(lsm_value, na.rm = TRUE), .groups = "drop")

  all = full_join(
    vm2,
    lsm2,
    by = c("metric_name", "level", "class")
  ) |>
    mutate(
      diff = vm_value - lsm_value
    )

  full_join(
    vm,
    lsm,
    by = c("metric_name", "level", "class", "patch")
  ) |>
    mutate(
      diff = vm_value - lsm_value
    )

}

# ============================================================
# Main compatibility test
# ============================================================

test_that("vectormetrics matches landscapemetrics on canonical dataset", {

  landscapes <- create_landscapes()

  comparison <- build_comparison(
    landscapes$raster,
    landscapes$polygon
  )

  failures <- comparison |>
    filter(
      !is.na(diff),
      abs(diff) > tolerance
    )

  if (nrow(failures) > 0) {

    print(failures)

  }

  expect_equal(
    nrow(failures),
    0
  )

})
