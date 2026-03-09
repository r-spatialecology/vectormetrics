# Total (landscape) edge (vector data)

Calculate the total length of all edges in a categorical landscape in
vector data format

## Usage

``` r
vm_l_te(landscape, count_boundary = TRUE)
```

## Arguments

- landscape:

  the input landscape image

- count_boundary:

  Include landscape boundary in edge length (default: TRUE)

## Value

A tibble with the calculated edge length in the "value" column, along
with level and metric name metadata

## Details

Total edge is calculated as the sum of all unique edge segments in the
landscape. Shared edges between patches are counted only once (not
double-counted). By default (count_boundary=TRUE), the outer landscape
boundary is included. If count_boundary=FALSE, only internal edges
between patches are included.

Note: The default differs from landscapemetrics (default: FALSE) because
vector polygon boundaries are explicit geometric features, while raster
landscapes have implicit grid boundaries. Set count_boundary=FALSE for
direct comparison with landscapemetrics results.

The calculation uses: internal_edges = (sum_all_perimeters -
outer_boundary) / 2

## Examples

``` r
vm_l_te(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    te       497
vm_l_te(vector_landscape, count_boundary = FALSE)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    te       377
```
