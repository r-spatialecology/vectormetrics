# Girth Index(vector data)

Calculate Girth Index

## Usage

``` r
vm_c_girth_mn(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between radius of maximum inscribed circle and radius of
equal-area circle

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_c_girth_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 class 1     NA    girth_mn 0.368
#> 2 class 2     NA    girth_mn 0.389
#> 3 class 3     NA    girth_mn 0.316
```
