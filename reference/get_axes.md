# Get major and minor axis

Get major axis (longest line between vertices) and minor axis (longest
line inside a shape that is perpendicular to major axis) of polygon

## Usage

``` r
get_axes(landscape, class_col = NULL, patch_col = NULL)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

## Value

sf object with exploded polygons

## Examples

``` r
get_axes(vector_landscape, "class")
#> MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_polygon_patches()'.
#> This message is displayed once per session.
#> # A tibble: 3 × 6
#>   level class id    metric    major minor
#>   <chr> <chr> <chr> <chr>     <dbl> <dbl>
#> 1 patch 1     1     main_axes  41.1  37.1
#> 2 patch 2     2     main_axes  38.8  36.2
#> 3 patch 3     3     main_axes  42.8  39.3
```
