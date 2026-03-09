# The standard deviation of Perimeter-Area ratio index of all patches at class level(vector data)

This function allows you to calculate the standard deviation of the
ratios of all patches belonging to one class in a categorical landscape
in vector data format

## Usage

``` r
vm_c_perarea_sd(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated standard deviation of each class is in column
"value", and this function returns also some important information such
as level, class number and metric name. Moreover, the "id" column,
although it is just NA here at class level. we need it because the
output struture of metrics at class level should correspond to patch
level one by one, and then it is more convinient to combine metric
values at different levels and compare them.

## Examples

``` r
vm_c_perarea_sd(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric     value
#>   <chr> <chr> <chr> <chr>      <dbl>
#> 1 class 1     NA    perarea_sd    NA
#> 2 class 2     NA    perarea_sd    NA
#> 3 class 3     NA    perarea_sd    NA
```
