# Shannon's diversity index (vector data)

This function allows you to calculate the Shannon's diversity index in a
categorical landscape in vector data format, Shannon's diversity index
is diversity index

## Usage

``` r
vm_l_shdi(landscape, class_col)
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
vm_l_shdi(vector_landscape, "class")
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    shdi    1.02
```
