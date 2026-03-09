# The mean value of number of core areas in landscape(vector data)

This function allows you to calculate the mean value of the total number
of disjunct core areas in a categorical landscape in vector data format

## Usage

``` r
vm_l_dcore_mn(landscape, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the returned calculated mean value of number of the whole landscape is
in column "value", and this function returns also some important
information such as level and metric name, Moreover, class number and
the "id" column, although both are "NA" here in the landscape level

## Examples

``` r
vm_l_dcore_mn(vector_landscape, edge_depth= 1)
#> # A tibble: 1 × 5
#>   level     class id    metric   value
#>   <chr>     <chr> <chr> <chr>    <dbl>
#> 1 landscape NA    NA    dcore_mn  5.67
```
