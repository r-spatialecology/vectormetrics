# Perimeter of the convex hull(vector data)

Calculate perimeter of the convex hull of the polygon

## Usage

``` r
get_hull_perim(landscape, class_col = NULL, patch_col = NULL)
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

perimeter of the convex hull of the polygon

## Examples

``` r
get_hull_perim(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric      value
#>    <chr> <chr> <chr> <chr>       <dbl>
#>  1 patch 1     11    convex_area 23.8 
#>  2 patch 1     12    convex_area 25.2 
#>  3 patch 1     13    convex_area 19.7 
#>  4 patch 1     14    convex_area  8.83
#>  5 patch 1     15    convex_area  4   
#>  6 patch 1     16    convex_area  4   
#>  7 patch 1     17    convex_area  4   
#>  8 patch 1     18    convex_area 10   
#>  9 patch 1     19    convex_area  4   
#> 10 patch 1     20    convex_area  4   
#> # ℹ 30 more rows
```
