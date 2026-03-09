# The mean value of the fractal dimension index of landscape(vector data)

This function allows you to calculate the mean value of fractal
dimension index in a categorical landscape in vector data format The
index is based on the patch perimeter and the patch area and describes
the patch complexity

## Usage

``` r
vm_l_frac_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image

## Value

the returned calculated mean value of the whole landscape is in column
"value", and this function returns also some important information such
as level and metric name, Moreover, class number and the "id" column,
although both are "NA" here in the landscape level

## Examples

``` r
vm_l_frac_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    frac_mn  1.53
```
