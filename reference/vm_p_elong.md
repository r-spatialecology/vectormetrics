# Elongation(vector data)

Calculate elongation of shape

## Usage

``` r
vm_p_elong(landscape, class_col = NULL, patch_col = NULL)
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

ratio between major and minor axis length

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_p_elong(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    elong  0.511
#>  2 patch 1     12    elong  0.187
#>  3 patch 1     13    elong  0.384
#>  4 patch 1     14    elong  0.383
#>  5 patch 1     15    elong  0    
#>  6 patch 1     16    elong  0    
#>  7 patch 1     17    elong  0    
#>  8 patch 1     18    elong  0.335
#>  9 patch 1     19    elong  0    
#> 10 patch 1     20    elong  0    
#> # ℹ 30 more rows
```
