# The mean value of all patch areas at landscape level(vector data)

This function allows you to calculate the mean value of all patch areas
in a categorical landscape in vector data format

## Usage

``` r
vm_l_area_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated mean value of areas is in column "value", and
this function returns also some important information such as level and
metric name,

## Examples

``` r
vm_l_area_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    area_mn  0.03
```
