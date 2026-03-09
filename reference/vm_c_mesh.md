# Effective Mesh Size (vector data)

This function helps to analyse the patch structure the calculate process
is, each patch is squared before the sums for each class i are
calculated and the sum is standardized by the total landscape area. it
is a aggregation metric.

## Usage

``` r
vm_c_mesh(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated values are in column "value", and this function
returns also some important information such as level, class number and
metric name. Moreover, the "id" column, although it is just NA here at
class level. we need it because the output struture of metrics at class
level should correspond to patch level one by one, and then it is more
convinient to combine metric values at different levels and compare
them.

## Examples

``` r
vm_c_mesh(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 class 1     NA    mesh   0.00260
#> 2 class 2     NA    mesh   0.01   
#> 3 class 3     NA    mesh   0.0222 
```
