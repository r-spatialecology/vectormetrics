# Cohesion Index(vector data)

Calculate Cohesion Index

## Usage

``` r
vm_c_coh_mn(landscape, class_col, n = 1000)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- n:

  number of grid points to generate

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

Mean cohesion across all patches in each class. Cohesion is the ratio of
the average distance-squared among all points in an equal-area circle to
the average distance-squared among all points in the shape. Values
closer to 1 indicate shapes more similar to circles.

## References

Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties
of circles: Measuring shape in geography: Ten compactness properties of
circles. The Canadian Geographer / Le Géographe Canadien, 54(4),
441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x

## Examples

``` r
vm_c_coh_mn(vector_landscape, "class", n = 1000)
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    coh_mn 0.452
#> 2 class 2     NA    coh_mn 0.633
#> 3 class 3     NA    coh_mn 0.773
```
