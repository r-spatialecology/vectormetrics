# Largest patch index(vector data)

This function allows you to calculate the maximal patch area in relative
to total landscape area in a categorical landscape in vector data format

## Usage

``` r
vm_l_lpi(landscape)
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
vm_l_lpi(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    lpi     49.7
```
