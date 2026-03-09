# The mean value of all core areas in each class(vector data)

This function allows you to calculate the mean value of all core patch
areas belonging to one class in a categorical landscape in vector data
format

## Usage

``` r
vm_c_core_mn(landscape, class_col, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the returned calculated mean value of core areas of each class is in
column "value", and this function returns also some important
information such as level, class number and metric name. Moreover, the
"id" column, although it is just NA here at class level. we need it
because the output struture of metrics at class level should correspond
to patch level one by one, and then it is more convinient to combine
metric values at different levels and compare them.

## Examples

``` r
vm_c_core_mn(vector_landscape, "class", edge_depth = 1)
#> # A tibble: 3 × 5
#>   level class id    metric    value
#>   <chr> <chr> <chr> <chr>     <dbl>
#> 1 class 1     NA    core_mn 0.00245
#> 2 class 2     NA    core_mn 0.00839
#> 3 class 3     NA    core_mn 0.0156 
```
