# The perimeter of patch(vector data)

This function allows you to calculate the perimeter of each patch in a
categorical landscape in vector data format

## Usage

``` r
vm_p_perim(landscape, class_col = NULL, patch_col = NULL)
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
vm_p_perim(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    perim     30
#>  2 patch 1     12    perim     30
#>  3 patch 1     13    perim     24
#>  4 patch 1     14    perim     10
#>  5 patch 1     15    perim      4
#>  6 patch 1     16    perim      4
#>  7 patch 1     17    perim      4
#>  8 patch 1     18    perim     10
#>  9 patch 1     19    perim      4
#> 10 patch 1     20    perim      4
#> # ℹ 30 more rows
```
