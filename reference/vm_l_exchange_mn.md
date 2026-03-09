# Exchange Index(vector data)

Calculate Exchange Index

## Usage

``` r
vm_l_exchange_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

share of the total area of the shape that is inside the equal-area
circle about its centroid

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_l_exchange_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric      value
#>   <chr>     <chr> <chr> <chr>       <dbl>
#> 1 landscape NA    NA    exchange_mn 0.381
```
