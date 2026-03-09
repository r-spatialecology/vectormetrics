# The coefficient of variation of Euclidean Nearest-Neighbor Distance of all patches at class level(vector data)

This function allows you to calculate the coefficient of variation of
the Euclidean Nearest-Neighbor Distance among patches of one class in a
categorical landscape in vector data format Euclidean Nearest-Neighbor
Distance means the distance from a patch edge to the nearest
neighbouring patch belonging to the same class.

## Usage

``` r
vm_c_enn_cv(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated coefficient of variation of each class is in
column "value", and this function returns also some important
information such as level, class number and metric name. Moreover, the
"id" column, although it is just NA here at class level. we need it
because the output struture of metrics at class level should correspond
to patch level one by one, and then it is more convinient to combine
metric values at different levels and compare them.

## Examples

``` r
vm_c_enn_cv(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    enn_cv    NA
#> 2 class 2     NA    enn_cv    NA
#> 3 class 3     NA    enn_cv    NA
```
