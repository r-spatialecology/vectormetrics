# Splitting index (vector data)

This function allows you to calculate the relation between square of
landscape area and sum of square of all patch area of class i in a
categorical landscape in vector data format it is a aggregation metric.

## Usage

``` r
vm_c_split(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated indices are in column "value", and this function
returns also some important information such as level, class number and
metric name. Moreover, the "id" column, although it is just NA here at
class level. we need it because the output struture of metrics at class
level should correspond to patch level one by one, and then it is more
convinient to combine metric values at different levels and compare
them.

## Examples

``` r
vm_c_split(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    split  34.6 
#> 2 class 2     NA    split   9   
#> 3 class 3     NA    split   4.05
```
