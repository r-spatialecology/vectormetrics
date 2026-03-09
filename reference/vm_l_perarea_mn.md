# The mean value of all patches Perimeter-Area ratio index at landscape level(vector data)

This function allows you to calculate the mean value of all patch ratios
in a categorical landscape in vector data format

## Usage

``` r
vm_l_perarea_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated mean value is in column "value", and this
function returns also some important information such as level and
metric name, Moreover, class number and the "id" column, although both
are "NA" here in the landscape level

## Examples

``` r
vm_l_perarea_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric     value
#>   <chr>     <chr> <chr> <chr>      <dbl>
#> 1 landscape NA    NA    perarea_mn  1.08
```
