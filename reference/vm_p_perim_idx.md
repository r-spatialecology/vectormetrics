# Perimeter Index(vector data)

Calculate Perimeter Index

## Usage

``` r
vm_p_perim_idx(landscape, class_col = NULL, patch_col = NULL)
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

ratio between perimeter of equal-area circle and perimeter of polygon

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_p_perim_idx(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric    value
#>    <chr> <chr> <chr> <chr>     <dbl>
#>  1 patch 1     11    perim_idx 0.603
#>  2 patch 1     12    perim_idx 0.728
#>  3 patch 1     13    perim_idx 0.661
#>  4 patch 1     14    perim_idx 0.709
#>  5 patch 1     15    perim_idx 0.886
#>  6 patch 1     16    perim_idx 0.886
#>  7 patch 1     17    perim_idx 0.886
#>  8 patch 1     18    perim_idx 0.868
#>  9 patch 1     19    perim_idx 0.886
#> 10 patch 1     20    perim_idx 0.886
#> # ℹ 30 more rows
```
