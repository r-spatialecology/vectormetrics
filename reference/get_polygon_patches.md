# Get patches from polygon landscape

Convert multipolygons to separate polygons based on chosen neighbourhood
type.

## Usage

``` r
get_polygon_patches(landscape, class_col, direction = 4)

# S3 method for class 'sf'
get_polygon_patches(landscape, class_col, direction = 4)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- direction:

  4 or 8

## Value

sf object with exploded polygons

## Examples

``` r
get_polygon_patches(vector_landscape, "class", direction = 4)
#> Number of patches before conversion: 3
#> Number of patches after conversion: 40
#> Simple feature collection with 40 features and 2 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0 ymin: 0 xmax: 30 ymax: 30
#> CRS:           NA
#> First 10 features:
#>    class patch                       geometry
#> 1      1     1 POLYGON ((1 2, 0 2, 0 3, 0 ...
#> 2      1     2 POLYGON ((14 5, 15 5, 16 5,...
#> 3      1     3 POLYGON ((12 18, 12 19, 12 ...
#> 4      1     4 POLYGON ((10 19, 10 18, 9 1...
#> 5      1     5 POLYGON ((5 20, 6 20, 6 19,...
#> 6      1     6 POLYGON ((6 21, 7 21, 7 20,...
#> 7      1     7 POLYGON ((3 16, 4 16, 4 15,...
#> 8      1     8 POLYGON ((2 24, 2 23, 2 22,...
#> 9      1     9 POLYGON ((10 20, 11 20, 11 ...
#> 10     1    10 POLYGON ((13 24, 14 24, 14 ...
```
