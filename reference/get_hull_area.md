# Area of the convex hull(vector data)

Calculate area of the convex hull of the polygon

## Usage

``` r
get_hull_area(landscape, class_col = NULL, patch_col = NULL)
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

area of the convex hull of the polygon

## Examples

``` r
get_hull_area(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric      value
#>    <chr> <chr> <chr> <chr>       <dbl>
#>  1 patch 1     11    convex_area  32  
#>  2 patch 1     12    convex_area  45.5
#>  3 patch 1     13    convex_area  25.5
#>  4 patch 1     14    convex_area   5  
#>  5 patch 1     15    convex_area   1  
#>  6 patch 1     16    convex_area   1  
#>  7 patch 1     17    convex_area   1  
#>  8 patch 1     18    convex_area   6  
#>  9 patch 1     19    convex_area   1  
#> 10 patch 1     20    convex_area   1  
#> # ℹ 30 more rows
```
