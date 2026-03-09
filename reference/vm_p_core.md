# CORE (patch level)

Core area (Core area metric)

## Usage

``` r
vm_p_core(landscape, class_col = NULL, patch_col = NULL, edge_depth)
```

## Arguments

- landscape:

  \*sf\* MULTIPOLYGON or POLYGON feature

- class_col:

  Name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

- edge_depth:

  Distance (in map units) a location has the be away from the patch edge
  to be considered as core location

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

\$\$CORE = a\_{ij}^{core}\$\$ where \\a\_{ij}^{core}\\ is the core area
in square meters

CORE is a 'Core area metric' and equals the area within a patch that is
not on the edge of it. A location is defined as core area if the
location has no neighbour with a different value than itself. It
describes patch area and shape simultaneously (more core area when the
patch is large and the shape is rather compact, i.e. a square).

### Units

Hectares

### Range

CORE \>= 0

### Behaviour

Increases, without limit, as the patch area increases and the patch
shape simplifies (more core area). CORE = 0 when every location in the
patch is an edge.

## References

McGarigal, K., SA Cushman, and E Ene. 2012. FRAGSTATS v4: Spatial
Pattern Analysis Program for Categorical and Continuous Maps. Computer
software program produced by the authors at the University of
Massachusetts, Amherst. Available at the following web site:
http://www.umass.edu/landeco/research/fragstats/fragstats.html

## Examples

``` r
vm_p_core(vector_patches, "class", "patch", edge_depth = 0.8)
#> # A tibble: 40 × 5
#>    level class id    metric     value
#>    <chr> <chr> <chr> <chr>      <dbl>
#>  1 patch 1     11    core   0.000784 
#>  2 patch 1     12    core   0.00178  
#>  3 patch 1     13    core   0.000503 
#>  4 patch 1     14    core   0        
#>  5 patch 1     15    core   0        
#>  6 patch 1     16    core   0        
#>  7 patch 1     17    core   0        
#>  8 patch 1     18    core   0.0000560
#>  9 patch 1     19    core   0        
#> 10 patch 1     20    core   0        
#> # ℹ 30 more rows
```
