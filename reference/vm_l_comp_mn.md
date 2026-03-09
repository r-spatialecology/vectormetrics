# Form factor/Compactness(vector data)

Calculate form factor or compactness

## Usage

``` r
vm_l_comp_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

Mean compactness across all patches in the landscape. Compactness is
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
vm_l_comp_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric   value
#>   <chr>     <chr> <chr> <chr>    <dbl>
#> 1 landscape NA    NA    comp_mn 0.0422
```
