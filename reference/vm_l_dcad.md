# Disjunct core area density of the whole landscape(vector data)

This function allows you to calculate the number of disjunct core areas
in relation to the landscape area in a categorical landscape in vector
data format

## Usage

``` r
vm_l_dcad(landscape, edge_depth)
```

## Arguments

- landscape:

  the input landscape image,

- edge_depth:

  the fixed distance to the edge of the patch (in map units). This
  parameter is required to ensure you explicitly consider the
  appropriate scale for your data and your problem.

## Value

the returned calculated ratios are in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_dcad(vector_landscape, edge_depth = 1)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    dcad   18889.
```
