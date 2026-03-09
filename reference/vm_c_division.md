# Landscape division index of each class (vector data)

Calculate the division index for each class, reflecting the probability
that two randomly selected points are not in the same patch.

## Usage

``` r
vm_c_division(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape

- class_col:

  the name of the class column

## Value

A tibble with division index values (0-1)

## Details

Calculated as: \$\$DIVISION = 1 - \sum (A_i / A\_{landscape})^2\$\$
Range: 0 to 1 (unitless). Higher values indicate more fragmentation.

## Examples

``` r
vm_c_division(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric   value
#>   <chr> <chr> <chr> <chr>    <dbl>
#> 1 class 1     NA    division 0.971
#> 2 class 2     NA    division 0.889
#> 3 class 3     NA    division 0.753
```
