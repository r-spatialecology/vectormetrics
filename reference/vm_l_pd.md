# the patch density in the whole landscape(vector data)

This metric is based on categorical landscape in vector data format. The
density is the number of patches of the whole landscape relative to the
total landscape area. Then the number is standardised, so that the
comparison among different landscape is possible.

## Usage

``` r
vm_l_pd(landscape)
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
vm_l_pd(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    pd     3333.
```
