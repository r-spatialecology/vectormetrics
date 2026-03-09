# Landscape division index (vector data)

Calculate the division index for the entire landscape, reflecting the
probability that two randomly selected points are not in the same patch.

## Usage

``` r
vm_l_division(landscape)
```

## Arguments

- landscape:

  the input landscape

## Value

A tibble with division index value (0-1)

## Details

Calculated as: \$\$DIVISION = 1 - \sum (A_i / A\_{landscape})^2\$\$
Range: 0 to 1 (unitless). Higher values indicate more fragmentation.

## Examples

``` r
vm_l_division(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric   value
#>   <chr>     <chr> <chr> <chr>    <dbl>
#> 1 landscape NA    NA    division 0.613
```
