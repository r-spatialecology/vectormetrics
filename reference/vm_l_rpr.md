# Relative patch richness (vector data)

This function allows you to calculate the Relative patch richness in a
categorical landscape in vector data format, Relative patch richness is
diversity index

## Usage

``` r
vm_l_rpr(landscape, class_col, classes_max)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- classes_max:

  the maximal number of class in your input landscape image

## Value

the returned calculated index is in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Examples

``` r
vm_l_rpr(vector_landscape, classes_max = 3)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    rpr     66.7
```
