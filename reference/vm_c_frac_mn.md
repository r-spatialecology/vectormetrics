# The mean value of the fractal dimension index of all patches in each class(vector data)

This function allows you to calculate the mean value of fractal
dimension index of all patches belonging to class i in a categorical
landscape in vector data format The index is based on the patch
perimeter and the patch area and describes the patch complexity

## Usage

``` r
vm_c_frac_mn(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated mean value of each class is in column "value",
and this function returns also some important information such as level,
class number and metric name. Moreover, the "id" column, although it is
just NA here at class level. we need it because the output struture of
metrics at class level should correspond to patch level one by one, and
then it is more convinient to combine metric values at different levels
and compare them.

## Examples

``` r
vm_c_frac_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric  value
#>   <chr> <chr> <chr> <chr>   <dbl>
#> 1 class 1     NA    frac_mn  1.60
#> 2 class 2     NA    frac_mn  1.50
#> 3 class 3     NA    frac_mn  1.47
```
