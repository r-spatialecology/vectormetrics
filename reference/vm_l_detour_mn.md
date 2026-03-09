# Detour Index(vector data)

Calculate Detour Index

## Usage

``` r
vm_l_detour_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between perimeter of equal-area circle and perimeter of convex
hull of polygon

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_l_detour_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric    value
#>   <chr>     <chr> <chr> <chr>     <dbl>
#> 1 landscape NA    NA    detour_mn 0.534
```
