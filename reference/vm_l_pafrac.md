# Perimeter-Area Fractal Dimension(vector data)

This function allows you to get the result of 2 divided by ß, ß is the
slope of the regression of the area against the perimeter in logarithm
of all patches in a categorical landscape in vector data format

## Usage

``` r
vm_l_pafrac(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated slope is in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_pafrac(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    pafrac 0.897
```
