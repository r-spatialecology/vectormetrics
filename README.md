
<!-- To render, run:
rmarkdown::render("README.Rmd")
-->
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/Nowosad/vectormetrics/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Nowosad/vectormetrics/actions/workflows/R-CMD-check.yaml)
[![CodecovTestCoverage](https://codecov.io/gh/Nowosad/vectormetrics/branch/master/graph/badge.svg)](https://app.codecov.io/gh/Nowosad/vectormetrics?branch=master)
<!-- badges: end -->

## Overview

`vectormetrics` is a R package for calculating landscape and shape
metrics for vector layers. Its aim is to provide a set of metrics that
can characterize landscape patterns and properties of the shapes defined
as polygons and multipolygons. Whole package is based on Simple Feature
geometry format provided by `sf` package. Every function can be used in
a piped workflow, as it always takes the data as the first argument and
returns a `tibble`.

### Citation

how to cite this package

## Installation

You can install the released version of `vectormetrics` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("vectormetrics")
```

You can also download most recent development version of the package
from GitHub with:

``` r
remotes::install_github("Nowosad/vectormetrics")
```

## Using vectormetrics

### Function names structure

All functions in `landscapemetrics` start with *vm\_* (for vector
landscape metrics). The second part of the name specifies the level
(patch - *p*, class - *c* or landscape - *l*). The last part of the
function name is the abbreviation of the corresponding metric (e.g. enn
for the euclidean nearest-neighbor distance and rect for the
rectangularity). Some landscape and class level functions have also a
suffix at the end, that specifies the aggregation method (e.g. mean,
sd).

``` r
# Patch level
## vm_p_"metric"
vm_p_area()
vm_p_square()

# Class level
## vm_c_"metric"[_"aggregation"]
vm_c_np()
vm_c_square_mn()

# Landscape level
## vm_l_"metric"[_"aggregation"]
vm_l_lpi()
vm_l_square_mn()
```

### Examples

Some examples of calculating metrics on all levels and with different
class and patch columns.

``` r
library(vectormetrics)

vector_landscape = sf::st_as_sf(vector_landscape)
plot(vector_landscape)
```

<img src="man/figures/README-vector_landscape-1.png" width="100%" />

``` r
## Shape index
vm_p_shape(vector_landscape, "class")
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> # A tibble: 3 x 5
#>   level class    id metric value
#>   <chr> <int> <int> <chr>  <dbl>
#> 1 patch     1     1 shape   4.03
#> 2 patch     2     2 shape   4.43
#> 3 patch     3     3 shape   4.70

## Number of patches
vm_c_np(vector_landscape, "class")
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> # A tibble: 3 x 5
#>   level class    id metric value
#>   <chr> <int> <int> <chr>  <int>
#> 1 class     1    NA np         1
#> 2 class     2    NA np         1
#> 3 class     3    NA np         1

## Largest patch index
vm_l_lpi(vector_landscape, "class")
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> # A tibble: 1 x 5
#>   level     class    id metric value
#>   <chr>     <int> <int> <chr>  <dbl>
#> 1 landscape    NA    NA lpi     53.6

## Mean squareness
vm_l_square_mn(vector_landscape, "class")
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.
#> # A tibble: 1 x 5
#>   level     class    id metric value
#>   <chr>     <int> <int> <chr>  <dbl>
#> 1 landscape    NA    NA sq_mn  0.258
```

### Utility functions

``` r
vector_patches = get_patches(vector_landscape, "class")
vector_patches
#> Simple feature collection with 30 features and 2 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0 ymin: 0 xmax: 30 ymax: 30
#> CRS:           NA
#> First 10 features:
#>    class patch                       geometry
#> 1      1     1 POLYGON ((5 1, 6 1, 6 0, 5 ...
#> 2      1     2 POLYGON ((7 7, 8 7, 8 6, 7 ...
#> 3      1     3 POLYGON ((8 9, 7 9, 6 9, 5 ...
#> 4      1     4 POLYGON ((11 4, 12 4, 12 3,...
#> 5      1     5 POLYGON ((14 10, 15 10, 15 ...
#> 6      1     6 POLYGON ((26 4, 27 4, 27 3,...
#> 7      1     7 POLYGON ((22 0, 21 0, 20 0,...
#> 8      1     8 POLYGON ((19 2, 20 2, 20 1,...
#> 9      1     9 POLYGON ((18 15, 17 15, 16 ...
#> 10     1    10 POLYGON ((0 23, 1 23, 1 22,...

## Shape index
vm_p_shape(vector_patches, "class")
#> # A tibble: 30 x 5
#>    level class    id metric value
#>    <chr> <int> <int> <chr>  <dbl>
#>  1 patch     1     1 shape   1.13
#>  2 patch     1     2 shape   1.13
#>  3 patch     1     3 shape   1.87
#>  4 patch     1     4 shape   1.13
#>  5 patch     1     5 shape   1.55
#>  6 patch     1     6 shape   1.26
#>  7 patch     1     7 shape   1.20
#>  8 patch     1     8 shape   1.13
#>  9 patch     1     9 shape   2.14
#> 10 patch     1    10 shape   1.51
#> # i 20 more rows

## Number of patches
vm_c_np(vector_patches, "class")
#> # A tibble: 3 x 5
#>   level class    id metric value
#>   <chr> <int> <int> <chr>  <int>
#> 1 class     1    NA np        11
#> 2 class     2    NA np        13
#> 3 class     3    NA np         6

## Mean squareness
vm_l_square_mn(vector_patches, "class")
#> # A tibble: 1 x 5
#>   level     class    id metric value
#>   <chr>     <int> <int> <chr>  <dbl>
#> 1 landscape    NA    NA sq_mn  0.804
```

``` r
get_axes(vector_patches, "class")
#> # A tibble: 30 x 6
#>    level class    id metric    major minor
#>    <chr> <int> <int> <chr>     <dbl> <dbl>
#>  1 patch     1     1 main_axes  1.42  1.42
#>  2 patch     1     2 main_axes  1.42  1.42
#>  3 patch     1     3 main_axes 17.0  11.5 
#>  4 patch     1     4 main_axes  1.42  1.42
#>  5 patch     1     5 main_axes  7.32  5.02
#>  6 patch     1     6 main_axes  3.88  2.68
#>  7 patch     1     7 main_axes  2.82  1.42
#>  8 patch     1     8 main_axes  1.42  1.42
#>  9 patch     1     9 main_axes 17.2  12.7 
#> 10 patch     1    10 main_axes  4.78  2.62
#> # i 20 more rows
```

## Contributing

how to contribute

## References

list of references
