# List available metrics in vectormetrics

Returns a tibble with information about all available metrics in the
vectormetrics package.

## Usage

``` r
list_vm(level = NULL, metric = NULL, name = NULL, type = NULL, what = NULL)
```

## Arguments

- level:

  Optional. Character vector of levels to include. One or more of
  \`"patch"\`, \`"class"\`, or \`"landscape"\`. If \`NULL\` (default),
  all levels are returned.

- metric:

  Optional. Character vector of metric abbreviations to include (e.g.,
  \`"area"\`, \`"enn"\`). If \`NULL\` (default), all metrics are
  returned.

- name:

  Optional. Character vector of metric names to include (e.g.,
  \`"area"\`, \`"core area"\`). If \`NULL\` (default), all metrics are
  returned.

- type:

  Optional. Character vector of metric types to include (e.g., \`"shape
  metric"\`, \`"area and edge metric"\`). If \`NULL\` (default), all
  types are returned.

- what:

  Optional. Not used. Included for compatibility with
  \`landscapemetrics::list_lsm()\`.

## Value

A tibble with columns:

- metric:

  Abbreviation of the metric (e.g., \`"area"\`, \`"enn"\`)

- name:

  Full name of the metric

- type:

  Type of metric (e.g., \`"shape metric"\`, \`"aggregation metric"\`)

- level:

  Level of calculation: \`"patch"\`, \`"class"\`, or \`"landscape"\`

- function_name:

  R function name to calculate the metric

## Examples

``` r
if (FALSE) { # \dontrun{
# List all available metrics
list_vm()

# List only patch-level metrics
list_vm(level = "patch")

# List only shape metrics
list_vm(type = "shape metric")

# List metrics with specific abbreviation
list_vm(metric = "area")
} # }
```
