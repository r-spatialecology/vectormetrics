# Circularity(vector data)

Circularity convexity

## Usage

``` r
vm_l_circ_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

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
vm_l_circ_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric   value
#>   <chr>     <chr> <chr> <chr>    <dbl>
#> 1 landscape NA    NA    circ_mn 0.0422
```
