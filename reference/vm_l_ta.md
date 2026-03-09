# The total area of the whole landscape(vector data)

This function allows you to calculate the total area of the whole
landscape in a categorical landscape in vector data format

## Usage

``` r
vm_l_ta(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Examples

``` r
vm_l_ta(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    ta      0.09
```
