# Percentage of landscape of class(vector data)

This function allows you to calculate the percentage of each class in a
categorical landscape in vector data format That means each class area
is standardised by the total landscape area, so the comparision among
different landscape is possible.

## Usage

``` r
vm_c_pland(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated percentage of each class is in column "value",
and this function returns also some important information such as level,
class number and metric name. Moreover, the "id" column, although it is
just NA here at class level. we need it because the output struture of
metrics at class level should correspond to patch level one by one, and
then it is more convinient to combine metric values at different levels
and compare them.

## Examples

``` r
vm_c_pland(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    pland   17  
#> 2 class 2     NA    pland   33.3
#> 3 class 3     NA    pland   49.7
```
