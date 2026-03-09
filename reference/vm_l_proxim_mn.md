# Proximity Index(vector data)

Calculate Proximity Index

## Usage

``` r
vm_l_proxim_mn(landscape, n = 1000)
```

## Arguments

- landscape:

  the input landscape image,

- n:

  number of grid points to generate

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between average distance from all points of equal-area circle to
its center and average distance from all points of shape to its center

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_l_proxim_mn(vector_landscape, n = 1000)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================================| 100%
#> # A tibble: 1 × 5
#>   level     class id    metric    value
#>   <chr>     <chr> <chr> <chr>     <dbl>
#> 1 landscape NA    NA    proxim_mn 0.568
```
