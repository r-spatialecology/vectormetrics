# Edge density(vector data)

This function allows you to calculate the edge density of class i in a
categorical landscape in vector data format

## Usage

``` r
vm_c_ed(landscape, class_col, count_boundary = TRUE)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

- count_boundary:

  Include landscape boundary in edge length (default: TRUE)

## Value

the returned calculated length is in column "value", and this function
returns also some important information such as level, class number and
metric name. Moreover, the "id" column, although it is just NA here at
class level. we need it because the output struture of metrics at class
level should correspond to patch level one by one, and then it is more
convinient to combine metric values at different levels and compare
them.

## Details

Edge density is calculated as the total edge length divided by total
landscape area (in m/ha).

Note: The default differs from landscapemetrics (default: FALSE) because
vector polygon boundaries are explicit geometric features. Set
count_boundary=FALSE for direct comparison with landscapemetrics
results.

## Examples

``` r
vm_c_ed(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    ed     2467.
#> 2 class 2     NA    ed     3244.
#> 3 class 3     NA    ed     4000 
vm_c_ed(vector_landscape, "class", count_boundary = FALSE)
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    ed     2111.
#> 2 class 2     NA    ed     3056.
#> 3 class 3     NA    ed     3211.
```
