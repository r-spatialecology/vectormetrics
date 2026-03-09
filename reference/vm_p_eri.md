# Equivalent rectangular index(vector data)

Calculate Equivalent rectangular index (ERI)

## Usage

``` r
vm_p_eri(landscape, class_col = NULL, patch_col = NULL)
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

ratio between perimeter of equal-area rectangle of shape and perimeter
of shape

## References

Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and
classification schemes for characterising perceptual shape complexity of
building footprints in GIS. International Journal of Geographical
Information Science, 31(10), 1952–1977.
https://doi.org/10.1080/13658816.2017.1346257

## Examples

``` r
vm_p_eri(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    eri    0.737
#>  2 patch 1     12    eri    0.824
#>  3 patch 1     13    eri    0.745
#>  4 patch 1     14    eri    0.816
#>  5 patch 1     15    eri    1    
#>  6 patch 1     16    eri    1    
#>  7 patch 1     17    eri    1    
#>  8 patch 1     18    eri    1    
#>  9 patch 1     19    eri    1    
#> 10 patch 1     20    eri    1    
#> # ℹ 30 more rows
```
