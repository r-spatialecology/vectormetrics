# Rectangularity(vector data)

Calculate rectangularity

## Usage

``` r
vm_p_rect(landscape, class_col = NULL, patch_col = NULL)
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

ratio between area of shape and its minimum area bounding rectangle
(MABR)

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_p_rect(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    rect   0.722
#>  2 patch 1     12    rect   0.679
#>  3 patch 1     13    rect   0.546
#>  4 patch 1     14    rect   0.667
#>  5 patch 1     15    rect   1    
#>  6 patch 1     16    rect   1    
#>  7 patch 1     17    rect   1    
#>  8 patch 1     18    rect   1    
#>  9 patch 1     19    rect   1    
#> 10 patch 1     20    rect   1    
#> # ℹ 30 more rows
```
