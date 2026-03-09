# Effective Mesh Size (vector data)

This function helps to analyse the patch structure the calculate process
is, each patch is squared before the sums of them are calculated and the
sum is standardized by the total landscape area. it is a aggregation
metric.

## Usage

``` r
vm_l_mesh(landscape)
```

## Arguments

- landscape:

  the input landscape image

## Value

the returned calculated values are in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_mesh(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric  value
#>   <chr>     <chr> <chr> <chr>   <dbl>
#> 1 landscape NA    NA    mesh   0.0348
```
