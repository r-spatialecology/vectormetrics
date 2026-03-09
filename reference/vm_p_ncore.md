# the number of disjunct core area(vector data)

This function allows you to calculate the number of disjunct core areas
of all patches Core area is defined as an area that within the patch and
its edge is a fixed value from the boundary of the patch. Disjunct core
area is defined as a new discrete area(patch), which is a sub-part of
core area

## Usage

``` r
vm_p_ncore(landscape, class_col = NULL, patch_col = NULL, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

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
