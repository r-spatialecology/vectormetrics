# Sphercity(vector data)

Calculate sphercity

## Usage

``` r
vm_c_sphere_mn(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the function returns tibble with the calculated values in column
"value", this function returns also some important information such as
level, class, patch id and metric name.

## Details

ratio between radius of maximum inscribed circle and minimum
circumscribing circle

## Examples

``` r
vm_c_sphere_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric    value
#>   <chr> <chr> <chr> <chr>     <dbl>
#> 1 class 1     NA    sphere_mn 0.125
#> 2 class 2     NA    sphere_mn 0.202
#> 3 class 3     NA    sphere_mn 0.178
```
