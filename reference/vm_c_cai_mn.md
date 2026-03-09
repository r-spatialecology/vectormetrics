# The mean value of core area index at class level(vector data)

This function allows you to calculate the mean value of ratio of the
core area and the area belonging to one class in a categorical landscape
in vector data format

## Usage

``` r
vm_c_cai_mn(landscape, class_col, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the returned calculated mean value of core area index of each class is
in column "value", and this function returns also some important
information such as level, class number and metric name. Moreover, the
"id" column, although it is just NA here at class level. we need it
because the output struture of metrics at class level should correspond
to patch level one by one, and then it is more convinient to combine
metric values at different levels and compare them.

## Examples

``` r
vm_c_cai_mn(vector_landscape, "class", edge_depth = 1)
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    cai_mn  16.0
#> 2 class 2     NA    cai_mn  28.0
#> 3 class 3     NA    cai_mn  34.9
```
