# Perimeter-Area ratio.

This function allows you to calculate the ratio between the patch
perimeter and area. The ratio describes the patch complexity in a
straightforward way.

## Usage

``` r
vm_p_perarea(landscape, class_col = NULL, patch_col = NULL)
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

## Examples

``` r
vm_p_perarea(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric  value
#>    <chr> <chr> <chr> <chr>   <dbl>
#>  1 patch 1     11    perarea 1.15 
#>  2 patch 1     12    perarea 0.789
#>  3 patch 1     13    perarea 1.2  
#>  4 patch 1     14    perarea 2.5  
#>  5 patch 1     15    perarea 4    
#>  6 patch 1     16    perarea 4    
#>  7 patch 1     17    perarea 4    
#>  8 patch 1     18    perarea 1.67 
#>  9 patch 1     19    perarea 4    
#> 10 patch 1     20    perarea 4    
#> # ℹ 30 more rows
```
