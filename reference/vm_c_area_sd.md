# The standard deviation of all patch areas at class level(vector data)

This function allows you to calculate the standard deviation of all
patch areas belonging to one class in a categorical landscape in vector
data format

## Usage

``` r
vm_c_area_sd(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated standard deviation of areas of each class is in
column "value", and this function returns also some important
information such as level, class number and metric name.

## Examples

``` r
vm_c_area_sd(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric  value
#>   <chr> <chr> <chr> <chr>   <dbl>
#> 1 class 1     NA    area_sd    NA
#> 2 class 2     NA    area_sd    NA
#> 3 class 3     NA    area_sd    NA
```
