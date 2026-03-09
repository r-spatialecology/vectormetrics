# AREA (patch level)

Patch area (Area and edge metric)

## Usage

``` r
vm_p_area(landscape, class_col = NULL, patch_col = NULL)
```

## Arguments

- landscape:

  sf\* object.

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

\$\$AREA = a\_{ij} \* (\frac{1} {10000})\$\$ where \\a\_{ij}\\ is the
area in square meters.

AREA is an 'Area and edge metric' and equals the area of each patch in
hectares. The lower limit of AREA is limited by the resolution of the
input raster, i.e. AREA can't be smaller than the resolution squared (in
hectares). It is one of the most basic, but also most important metrics,
to characterise a landscape. The metric is the simplest measure of
composition.

### Units

Hectares

### Range

AREA \> 0

### Behaviour

Increases, without limit, as the patch size increases.

## References

McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial
Pattern Analysis Program for Categorical and Continuous Maps. Computer
software program produced by the authors at the University of
Massachusetts, Amherst. Available at the following web site:
http://www.umass.edu/landeco/research/fragstats/fragstats.html

## Examples

``` r
vm_p_area(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric  value
#>    <chr> <chr> <chr> <chr>   <dbl>
#>  1 patch 1     11    area   0.0026
#>  2 patch 1     12    area   0.0038
#>  3 patch 1     13    area   0.002 
#>  4 patch 1     14    area   0.0004
#>  5 patch 1     15    area   0.0001
#>  6 patch 1     16    area   0.0001
#>  7 patch 1     17    area   0.0001
#>  8 patch 1     18    area   0.0006
#>  9 patch 1     19    area   0.0001
#> 10 patch 1     20    area   0.0001
#> # ℹ 30 more rows
```
