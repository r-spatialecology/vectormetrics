# Fullness Index(vector data)

Calculate Fullness Index

## Usage

``` r
vm_p_fullness(
  landscape,
  class_col = NULL,
  patch_col = NULL,
  n = 1000,
  progress = TRUE
)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- patch_col:

  the name of the id column of the input landscape

- n:

  number of local neighbourhoods to consider in calculating fullness

- progress:

  TRUE/FALSE, whether to show progress bar

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between the average fullness of small neighbourhoods (1

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_p_fullness(vector_landscape, class_col = "class", n = 1000)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================================| 100%
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 patch 1     1     full_idx 0.832
#> 2 patch 2     2     full_idx 0.852
#> 3 patch 3     3     full_idx 0.850
```
