# Euclidean Nearest-Neighbor Distance(vector data)

This function allows you to calculate the distance to the nearest
neighbouring patch of the same class in meters The distance is measured
from edge-to-edge.

## Usage

``` r
vm_p_enn(landscape, class_col = NULL, patch_col = NULL)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Examples

``` r
vm_p_enn(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    enn     4   
#>  2 patch 1     12    enn     1   
#>  3 patch 1     13    enn     0   
#>  4 patch 1     14    enn     0   
#>  5 patch 1     15    enn     0   
#>  6 patch 1     16    enn     0   
#>  7 patch 1     17    enn     3.16
#>  8 patch 1     18    enn     2   
#>  9 patch 1     19    enn     0   
#> 10 patch 1     20    enn     0   
#> # ℹ 30 more rows
```
