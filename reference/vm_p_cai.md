# Core area index(vector data)

This function allows you to calculate the ratio of the core area and the
area in square meters. Core area is defined as an area that within the
patch and its edge is a fixed value from the boundary of the patch. The
index describes the percentage of a patch that is core area.

## Usage

``` r
vm_p_cai(landscape, class_col = NULL, patch_col = NULL, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Examples

``` r
vm_p_cai(vector_patches, "class", "patch", edge_depth = 0.8)
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    cai    30.1 
#>  2 patch 1     12    cai    47.0 
#>  3 patch 1     13    cai    25.2 
#>  4 patch 1     14    cai     0   
#>  5 patch 1     15    cai     0   
#>  6 patch 1     16    cai     0   
#>  7 patch 1     17    cai     0   
#>  8 patch 1     18    cai     9.33
#>  9 patch 1     19    cai     0   
#> 10 patch 1     20    cai     0   
#> # ℹ 30 more rows
```
