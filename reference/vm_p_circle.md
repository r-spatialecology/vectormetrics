# CIRCLE (patch level)

Related Circumscribing Circle (Shape metric)

## Usage

``` r
vm_p_circle(landscape, class_col = NULL, patch_col = NULL)
```

## Arguments

- landscape:

  \*sf\* MULTIPOLYGON or POLYGON feature

- class_col:

  Name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

\$\$CIRCLE = 1 - (\frac{a\_{ij}} {a\_{ij}^{circle}})\$\$ where
\\a\_{ij}\\ is the area in square meters and \\a\_{ij}^{circle}\\ the
area of the smallest circumscribing circle.

CIRCLE is a 'Shape metric'. The metric is the ratio between the patch
area and the smallest circumscribing circle of the patch. The diameter
of the smallest circumscribing circle is the 'diameter' of the patch
connecting the opposing corner points of the polygon that are the
furthest away from each other. The metric characterises the compactness
of the patch and is comparable among patches with different area.

### Units

None

### Range

0 \<= CIRCLE \< 1

### Behaviour

CIRCLE = 0 for a circular patch and approaches CIRCLE = 1 for a linear
patch.

## References

McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial
Pattern Analysis Program for Categorical and Continuous Maps. Computer
software program produced by the authors at the University of
Massachusetts, Amherst. Available at the following web site:
http://www.umass.edu/landeco/research/fragstats/fragstats.html

Baker, W. L., and Y. Cai. 1992. The r.le programs for multiscale
analysis of landscape structure using the GRASS geographical information
system. Landscape Ecology 7: 291-302.

## Examples

``` r
vm_p_circle(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    circle 0.659
#>  2 patch 1     12    circle 0.395
#>  3 patch 1     13    circle 0.583
#>  4 patch 1     14    circle 0.608
#>  5 patch 1     15    circle 0.363
#>  6 patch 1     16    circle 0.363
#>  7 patch 1     17    circle 0.363
#>  8 patch 1     18    circle 0.412
#>  9 patch 1     19    circle 0.363
#> 10 patch 1     20    circle 0.363
#> # ℹ 30 more rows
```
