# Roughness index(vector data)

Calculate Roughness index (RI)

## Usage

``` r
vm_p_rough(landscape, class_col = NULL, patch_col = NULL, n = 100)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

- n:

  number of boundary points to generate

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

Roughness quantifies shape irregularity by measuring the variance in
distances from boundary points to the centroid. Calculated as the
squared mean distance from boundary points to centroid, normalized by
area and perimeter. The scaling constant is based on Basaraner &
Cetinkaya (2017). Higher values indicate more irregular, complex
boundaries.

## References

Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and
classification schemes for characterising perceptual shape complexity of
building footprints in GIS. International Journal of Geographical
Information Science, 31(10), 1952–1977.
https://doi.org/10.1080/13658816.2017.1346257

## Examples

``` r
vm_p_rough(vector_patches, "class", "patch", n = 100)
#> # A tibble: 40 × 5
#>    level class id    metric    value
#>    <chr> <chr> <chr> <chr>     <dbl>
#>  1 patch 1     11    rough_idx 0.480
#>  2 patch 1     12    rough_idx 0.553
#>  3 patch 1     13    rough_idx 0.457
#>  4 patch 1     14    rough_idx 0.564
#>  5 patch 1     15    rough_idx 0.863
#>  6 patch 1     16    rough_idx 0.810
#>  7 patch 1     17    rough_idx 0.861
#>  8 patch 1     18    rough_idx 0.839
#>  9 patch 1     19    rough_idx 0.827
#> 10 patch 1     20    rough_idx 0.828
#> # ℹ 30 more rows
```
