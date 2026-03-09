# Splitting index (vector data)

This function allows you to calculate the relation between square of
landscape area and sum of square of all patch area in a categorical
landscape in vector data format it is a aggregation metric.

## Usage

``` r
vm_l_split(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated indices are in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_split(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    split   2.59
```
