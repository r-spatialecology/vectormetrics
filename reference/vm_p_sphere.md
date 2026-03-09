# Sphercity(vector data)

Calculate sphercity

## Usage

``` r
vm_p_sphere(landscape, class_col = NULL, patch_col = NULL)
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

## Details

ratio between radius of maximum inscribed circle and minimum
circumscribing circle

## Examples

``` r
vm_p_sphere(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    sphere 0.380
#>  2 patch 1     12    sphere 0.575
#>  3 patch 1     13    sphere 0.393
#>  4 patch 1     14    sphere 0.325
#>  5 patch 1     15    sphere 0.707
#>  6 patch 1     16    sphere 0.707
#>  7 patch 1     17    sphere 0.707
#>  8 patch 1     18    sphere 0.555
#>  9 patch 1     19    sphere 0.707
#> 10 patch 1     20    sphere 0.707
#> # ℹ 30 more rows
```
