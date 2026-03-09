# Form factor/Compactness(vector data)

Calculate form factor or compactness

## Usage

``` r
vm_c_comp_mn(landscape, class_col)
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

Mean compactness across all patches in each class. Compactness is
calculated as: \$\$COMPACT = \frac{4\pi A}{P^2}\$\$ where \\A\\ is the
patch area (m²) and \\P\\ is the perimeter (m). Values range from 0
(linear) to 1 (circular).

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_c_comp_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 class 1     NA    comp_mn 0.0390
#> 2 class 2     NA    comp_mn 0.0442
#> 3 class 3     NA    comp_mn 0.0433
```
