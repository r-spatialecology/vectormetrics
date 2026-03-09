# The total core area of the whole landscape(vector data)

This function allows you to calculate the total core area in a
categorical landscape in vector data format

## Usage

``` r
vm_l_tca(landscape, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- edge_depth:

  the fixed distance to the edge of the patch

## Value

the returned calculated total class core areas are in column "value",
and this function returns also some important information such as level
and metric name, Moreover, class number and the "id" column, although
both are "NA" here in the landscape level

## Examples

``` r
vm_l_tca(vector_landscape, edge_depth= 1)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    tca    0.0265
```
