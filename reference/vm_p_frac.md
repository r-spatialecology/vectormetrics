# Fractal Dimension Index(vector data)

This function allows you to calculate index fractal dimension index. The
index is based on the patch perimeter and the patch area and describes
the patch complexity.

## Usage

``` r
vm_p_frac(landscape, class_col = NULL, patch_col = NULL)
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

2 \* log(perimeter) / log(area)

## Examples

``` r
vm_p_frac(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    frac    1.24
#>  2 patch 1     12    frac    1.11
#>  3 patch 1     13    frac    1.20
#>  4 patch 1     14    frac    1.32
#>  5 patch 1     15    frac    1   
#>  6 patch 1     16    frac    1   
#>  7 patch 1     17    frac    1   
#>  8 patch 1     18    frac    1.02
#>  9 patch 1     19    frac    1   
#> 10 patch 1     20    frac    1   
#> # ℹ 30 more rows
```
