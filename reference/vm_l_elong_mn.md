# Elongation(vector data)

Calculate elongation of shape

## Usage

``` r
vm_l_elong_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

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
vm_l_elong_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric    value
#>   <chr>     <chr> <chr> <chr>     <dbl>
#> 1 landscape NA    NA    elong_mn 0.0812
```
