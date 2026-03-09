# Solidity(vector data)

Calculate Solidity of shape

## Usage

``` r
vm_p_solid(landscape, class_col = NULL, patch_col = NULL)
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

ratio between area of convex hull and area of polygon

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_p_solid(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    solid  0.812
#>  2 patch 1     12    solid  0.835
#>  3 patch 1     13    solid  0.784
#>  4 patch 1     14    solid  0.8  
#>  5 patch 1     15    solid  1    
#>  6 patch 1     16    solid  1    
#>  7 patch 1     17    solid  1    
#>  8 patch 1     18    solid  1    
#>  9 patch 1     19    solid  1    
#> 10 patch 1     20    solid  1    
#> # ℹ 30 more rows
```
