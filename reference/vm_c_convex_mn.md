# Convexity(vector data)

Calculate convexity

## Usage

``` r
vm_c_convex_mn(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between perimeter of convex hull and perimeter of polygon

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_c_convex_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric  value
#>   <chr> <chr> <chr> <chr>   <dbl>
#> 1 class 1     NA    conv_mn 0.506
#> 2 class 2     NA    conv_mn 0.369
#> 3 class 3     NA    conv_mn 0.325
```
