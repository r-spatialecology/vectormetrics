# Fullness Index(vector data)

Calculate Fullness Index

## Usage

``` r
vm_c_fullness_mn(landscape, class_col, n = 1000)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- n:

  number of local neighbourhoods to consider in calculating fullness

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
vm_c_fullness_mn(vector_landscape, "class")
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================================| 100%
#> # A tibble: 3 × 5
#>   level class id    metric  value
#>   <chr> <chr> <chr> <chr>   <dbl>
#> 1 class 1     NA    full_mn 0.841
#> 2 class 2     NA    full_mn 0.859
#> 3 class 3     NA    full_mn 0.853
```
