# Exchange Index(vector data)

Calculate Exchange Index

## Usage

``` r
vm_p_exchange(landscape, class_col = NULL, patch_col = NULL)
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

share of the total area of the shape that is inside the equal-area
circle around its centroid

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_p_exchange(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric       value
#>    <chr> <chr> <chr> <chr>        <dbl>
#>  1 patch 1     11    exchange_idx 0.738
#>  2 patch 1     12    exchange_idx 0.870
#>  3 patch 1     13    exchange_idx 0.758
#>  4 patch 1     14    exchange_idx 0.727
#>  5 patch 1     15    exchange_idx 0.909
#>  6 patch 1     16    exchange_idx 0.909
#>  7 patch 1     17    exchange_idx 0.909
#>  8 patch 1     18    exchange_idx 0.833
#>  9 patch 1     19    exchange_idx 0.909
#> 10 patch 1     20    exchange_idx 0.909
#> # ℹ 30 more rows
```
