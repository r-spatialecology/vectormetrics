# The standard deviation of Ratios between the patch area and the smallest circumscribing circle of patches at class level(vector data)

This function allows you to calculate the standard deviation of ratios
of each class in a categorical landscape in vector data format the ratio
is the patch area relative to area of the smallest circumscribing circle
of the patch

## Usage

``` r
vm_c_circle_sd(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated standard deviation of ratios of each class is in
column "value", and this function returns also some important
information such as level, class number and metric name. Moreover, the
"id" column, although it is just NA here at class level. we need it
because the output struture of metrics at class level should correspond
to patch level one by one, and then it is more convinient to combine
metric values at different levels and compare them.

## Examples

``` r
vm_c_circle_sd(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric    value
#>   <chr> <chr> <chr> <chr>     <dbl>
#> 1 class 1     NA    circle_sd    NA
#> 2 class 2     NA    circle_sd    NA
#> 3 class 3     NA    circle_sd    NA
```
