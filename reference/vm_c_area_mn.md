# The mean value of all patch areas at class level(vector data)

This function allows you to calculate the mean value of all patch areas
belonging to one class in a categorical landscape in vector data format

## Usage

``` r
vm_c_area_mn(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated mean value of areas of each class is in column
"value", and this function returns also some important information such
as level, class number and metric name.

## Examples

``` r
vm_c_area_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 class 1     NA    area_mn 0.0153
#> 2 class 2     NA    area_mn 0.03  
#> 3 class 3     NA    area_mn 0.0447
```
