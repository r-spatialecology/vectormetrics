# Perimeter of equal-area circle(vector data)

Calculate perimeter of equal-area circle

## Usage

``` r
get_eac_perim(landscape, class_col = NULL, patch_col = NULL)
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

perimeter of equal-area circle

## Examples

``` r
get_eac_perim(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric       value
#>    <chr> <chr> <chr> <chr>        <dbl>
#>  1 patch 1     11    circle_perim 18.1 
#>  2 patch 1     12    circle_perim 21.9 
#>  3 patch 1     13    circle_perim 15.9 
#>  4 patch 1     14    circle_perim  7.09
#>  5 patch 1     15    circle_perim  3.54
#>  6 patch 1     16    circle_perim  3.54
#>  7 patch 1     17    circle_perim  3.54
#>  8 patch 1     18    circle_perim  8.68
#>  9 patch 1     19    circle_perim  3.54
#> 10 patch 1     20    circle_perim  3.54
#> # ℹ 30 more rows
```
