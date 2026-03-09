# The mean value of Ratios between the patch area and the smallest circumscribing circle of patches at class level(vector data)

This function allows you to calculate the mean value of ratios of each
class in a categorical landscape in vector data format the ratio is the
patch area relative to area of the smallest circumscribing circle of the
patch

## Usage

``` r
vm_l_circle_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated mean value of ratios of each class is in column
"value", and this function returns also some important information such
as level, class number and metric name. Moreover, the "id" column,
although it is just NA here at class level. we need it because the
output struture of metrics at class level should correspond to patch
level one by one, and then it is more convinient to combine metric
values at different levels and compare them.

## Examples

``` r
vm_l_circle_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric    value
#>   <chr>     <chr> <chr> <chr>     <dbl>
#> 1 landscape NA    NA    circle_mn 0.766
```
