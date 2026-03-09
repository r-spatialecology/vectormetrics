# Patch richness (vector data)

This function allows you to calculate the Patch richness in a
categorical landscape in vector data format, Patch richness index is a
simplest diversity index

## Usage

``` r
vm_l_pr(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated index is in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_pr(vector_landscape, "class")
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    pr         3
```
