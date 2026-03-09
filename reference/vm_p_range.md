# Range Index(vector data)

Calculate Range Index

## Usage

``` r
vm_p_range(landscape, class_col = NULL, patch_col = NULL)
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

ratio between diameter of equal-area circle and diameter of smallest
circumscribing circle

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_p_range(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric    value
#>    <chr> <chr> <chr> <chr>     <dbl>
#>  1 patch 1     11    range_idx 0.584
#>  2 patch 1     12    range_idx 0.778
#>  3 patch 1     13    range_idx 0.646
#>  4 patch 1     14    range_idx 0.626
#>  5 patch 1     15    range_idx 0.798
#>  6 patch 1     16    range_idx 0.798
#>  7 patch 1     17    range_idx 0.798
#>  8 patch 1     18    range_idx 0.767
#>  9 patch 1     19    range_idx 0.798
#> 10 patch 1     20    range_idx 0.798
#> # ℹ 30 more rows
```
