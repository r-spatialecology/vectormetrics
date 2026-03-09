# Squareness(vector data)

Calculate squareness

## Usage

``` r
vm_p_square(landscape, class_col = NULL, patch_col = NULL)
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

ratio between perimeter of equal-area square of shape and perimeter of
shape

## References

Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and
classification schemes for characterising perceptual shape complexity of
building footprints in GIS. International Journal of Geographical
Information Science, 31(10), 1952–1977.
https://doi.org/10.1080/13658816.2017.1346257

## Examples

``` r
vm_p_square(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    square 0.680
#>  2 patch 1     12    square 0.822
#>  3 patch 1     13    square 0.745
#>  4 patch 1     14    square 0.8  
#>  5 patch 1     15    square 1    
#>  6 patch 1     16    square 1    
#>  7 patch 1     17    square 1    
#>  8 patch 1     18    square 0.980
#>  9 patch 1     19    square 1    
#> 10 patch 1     20    square 1    
#> # ℹ 30 more rows
```
