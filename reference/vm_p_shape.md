# Shape index(vector data)

This function allows you to calculate the shape index, which is the
ratio between the actual perimeter of the patch and the hypothetical
minimum perimeter of the patch. The minimum perimeter equals the
perimeter if the patch would be maximally compact. That means, the
perimeter of a circle with the same area of the patch.

## Usage

``` r
vm_p_shape(landscape, class_col = NULL, patch_col = NULL)
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

## Examples

``` r
vm_p_shape(vector_patches, "class", "patch")
#> # A tibble: 40 × 5
#>    level class id    metric value
#>    <chr> <chr> <chr> <chr>  <dbl>
#>  1 patch 1     11    shape   1.66
#>  2 patch 1     12    shape   1.37
#>  3 patch 1     13    shape   1.51
#>  4 patch 1     14    shape   1.41
#>  5 patch 1     15    shape   1.13
#>  6 patch 1     16    shape   1.13
#>  7 patch 1     17    shape   1.13
#>  8 patch 1     18    shape   1.15
#>  9 patch 1     19    shape   1.13
#> 10 patch 1     20    shape   1.13
#> # ℹ 30 more rows
```
