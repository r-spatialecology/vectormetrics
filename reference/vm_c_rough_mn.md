# Roughness index(vector data)

Calculate Roughness index (RI)

## Usage

``` r
vm_c_rough_mn(landscape, class_col, n = 100)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- n:

  number of boundary points to generate

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

Mean roughness across all patches in each class. Roughness quantifies
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
vm_c_rough_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric    value
#>   <chr> <chr> <chr> <chr>     <dbl>
#> 1 class 1     NA    rough_mn 0.148 
#> 2 class 2     NA    rough_mn 0.0641
#> 3 class 3     NA    rough_mn 0.0528
```
