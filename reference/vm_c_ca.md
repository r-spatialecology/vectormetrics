# The total area of each class(vector data)

This function allows you to calculate the total area of each class in a
categorical landscape in vector data format

## Usage

``` r
vm_c_ca(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated total class areas are in column "value", and
this function returns also some important information such as level,
class number and metric name.

## Examples

``` r
vm_c_ca(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric  value
#>   <chr> <chr> <chr> <chr>   <dbl>
#> 1 class 1     NA    ca     0.0153
#> 2 class 2     NA    ca     0.03  
#> 3 class 3     NA    ca     0.0447
```
