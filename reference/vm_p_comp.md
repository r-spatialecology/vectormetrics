# Form factor/Compactness(vector data)

Calculate form factor or compactness

## Usage

``` r
vm_p_comp(landscape, class_col = NULL, patch_col = NULL)
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

Form factor (compactness) is calculated as: \$\$COMPACT = \frac{4\pi
A}{P^2}\$\$ where \\A\\ is the patch area (m²) and \\P\\ is the
perimeter (m). This is the isoperimetric quotient, ranging from 0
(linear) to 1 (circular). Higher values indicate more compact,
circle-like shapes.

## References

Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in
remote sensing imagery by shape metrics. ISPRS Journal of Photogrammetry
and Remote Sensing, 72, 46–55.
https://doi.org/10.1016/j.isprsjprs.2012.05.012

## Examples

``` r
vm_p_comp(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric  value
#>    <chr> <chr> <chr> <chr>   <dbl>
#>  1 patch 1     11    compact 0.363
#>  2 patch 1     12    compact 0.531
#>  3 patch 1     13    compact 0.436
#>  4 patch 1     14    compact 0.503
#>  5 patch 1     15    compact 0.785
#>  6 patch 1     16    compact 0.785
#>  7 patch 1     17    compact 0.785
#>  8 patch 1     18    compact 0.754
#>  9 patch 1     19    compact 0.785
#> 10 patch 1     20    compact 0.785
#> # ℹ 30 more rows
```
