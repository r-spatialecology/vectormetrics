# Perimeter-Area ratio.

This function allows you to calculate the ratio between the patch area
and perimeter. The ratio describes the patch complexity in a
straightforward way.

## Usage

``` r
vm_c_perarea_mn(landscape, class_col)
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

## Examples

``` r
vm_c_perarea_mn(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric     value
#>   <chr> <chr> <chr> <chr>      <dbl>
#> 1 class 1     NA    perarea_mn 1.45 
#> 2 class 2     NA    perarea_mn 0.973
#> 3 class 3     NA    perarea_mn 0.805
```
