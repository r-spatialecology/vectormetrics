# Roughness index(vector data)

Calculate Roughness index (RI)

## Usage

``` r
vm_l_rough_mn(landscape, n = 100)
```

## Arguments

- landscape:

  the input landscape image,

- n:

  number of boundary points to generate

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

Mean roughness across all patches in the landscape. Roughness quantifies
shape irregularity by measuring the variance in distances from boundary
points to the centroid, normalized by area and perimeter. Higher values
indicate more irregular, complex boundaries.

## References

Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and
classification schemes for characterising perceptual shape complexity of
building footprints in GIS. International Journal of Geographical
Information Science, 31(10), 1952–1977.
https://doi.org/10.1080/13658816.2017.1346257

## Examples

``` r
vm_l_rough_mn(vector_landscape, n = 100)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    ri_mn  0.0880
```
