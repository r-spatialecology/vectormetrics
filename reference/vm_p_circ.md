# Circularity(vector data)

Calculate Circularity

## Usage

``` r
vm_p_circ(landscape, class_col = NULL, patch_col = NULL)
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

ratio between area of polygon and area of equal-perimeter circle

## References

Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and
classification schemes for characterising perceptual shape complexity of
building footprints in GIS. International Journal of Geographical
Information Science, 31(10), 1952–1977.
https://doi.org/10.1080/13658816.2017.1346257

## Examples

``` r
vm_p_circ(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    circ   0.363
#>  2 patch 1     12    circ   0.531
#>  3 patch 1     13    circ   0.436
#>  4 patch 1     14    circ   0.503
#>  5 patch 1     15    circ   0.785
#>  6 patch 1     16    circ   0.785
#>  7 patch 1     17    circ   0.785
#>  8 patch 1     18    circ   0.754
#>  9 patch 1     19    circ   0.785
#> 10 patch 1     20    circ   0.785
#> # ℹ 30 more rows
```
