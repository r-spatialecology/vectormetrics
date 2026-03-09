# Sphercity(vector data)

Calculate sphercity

## Usage

``` r
vm_l_sphere_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between radius of maximum inscribed circle and minimum
circumscribing circle

## Examples

``` r
vm_l_sphere_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric    value
#>   <chr>     <chr> <chr> <chr>     <dbl>
#> 1 landscape NA    NA    sphere_mn 0.168
```
