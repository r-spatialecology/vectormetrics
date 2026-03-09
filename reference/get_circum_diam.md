# Diameter of smallest circumscribing circle(vector data)

Calculate diameter of smallest circumscribing circle

## Usage

``` r
get_circum_diam(landscape, class_col = NULL, patch_col = NULL)
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

diameter of smallest circumscribing circle

## Examples

``` r
get_circum_diam(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric      value
#>    <chr> <chr> <chr> <chr>       <dbl>
#>  1 patch 1     11    circum_diam  9.85
#>  2 patch 1     12    circum_diam  8.94
#>  3 patch 1     13    circum_diam  7.81
#>  4 patch 1     14    circum_diam  3.61
#>  5 patch 1     15    circum_diam  1.41
#>  6 patch 1     16    circum_diam  1.41
#>  7 patch 1     17    circum_diam  1.41
#>  8 patch 1     18    circum_diam  3.61
#>  9 patch 1     19    circum_diam  1.41
#> 10 patch 1     20    circum_diam  1.41
#> # ℹ 30 more rows
```
