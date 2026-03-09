# Calculate multiple vectormetrics at once

Wrapper function to calculate selected metrics for vector landscape
data.

## Usage

``` r
calculate_vm(
  landscape,
  level = NULL,
  metric = NULL,
  type = NULL,
  what = NULL,
  class_col = NULL,
  patch_col = NULL,
  verbose = TRUE,
  ...
)
```

## Arguments

- landscape:

  sf object with polygon or multipolygon geometry.

- level:

  Optional. Character vector of levels to include. One or more of
  \`"patch"\`, \`"class"\`, or \`"landscape"\`. If \`NULL\` (default),
  all levels are returned based on other arguments.

- metric:

  Optional. Character vector of metric abbreviations to include (e.g.,
  \`"area"\`, \`"enn"\`). If \`NULL\` (default), all metrics are
  returned based on other arguments.

- type:

  Optional. Character vector of metric types to include (e.g., \`"shape
  metric"\`, \`"area and edge metric"\`). If \`NULL\` (default), all
  types are returned based on other arguments.

- what:

  Optional. Character vector of function names to use (e.g.,
  \`c("vm_p_area", "vm_c_ca")\`). If specified, this overrides
  \`level\`, \`metric\`, and \`type\` arguments.

- class_col:

  Optional. The name of the class column in the landscape. Required for
  class-level metrics.

- patch_col:

  Optional. The name of the patch ID column. If \`NULL\`, patch IDs are
  generated automatically.

- verbose:

  Logical. Print warning messages. Default: \`TRUE\`.

- ...:

  Additional arguments passed to metric functions (e.g., \`edge_depth =
  0.8\` for core area metrics).

## Value

A tibble with columns: \`level\`, \`class\`, \`id\`, \`metric\`, and
\`value\`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Calculate patch-level metrics
# Note: edge_depth is needed for core area metrics (cai, core, ncore)
calculate_vm(vector_patches, level = "patch", edge_depth = 0.8)

# Calculate specific metrics by abbreviation (no additional arguments needed)
calculate_vm(vector_patches, metric = c("area", "perim"))

# Calculate specific functions
calculate_vm(vector_patches, what = c("vm_p_area", "vm_p_perim"))

# Calculate class-level metrics (requires class_col)
calculate_vm(vector_landscape, what = "vm_c_ca", class_col = "class")

# Calculate landscape-level metrics (some require class_col and edge_depth)
calculate_vm(vector_landscape, level = "landscape", class_col = "class",
             edge_depth = 0.8, class_max = 10)
} # }
```
