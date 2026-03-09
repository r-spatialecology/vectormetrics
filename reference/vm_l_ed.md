# ED (landscape level)

This function allows you to calculate the edge density (meters per
hectare) for the entire landscape in a categorical landscape in vector
data format

## Usage

``` r
vm_l_ed(landscape, count_boundary = TRUE)
```

## Arguments

- landscape:

  the input landscape image,

- count_boundary:

  Include landscape boundary in edge length (default: TRUE)

## Value

the returned calculated edge density is in column "value", and this
function returns also some important information such as level and
metric name, Moreover, class number and the "id" column, although both
are "NA" here in the landscape level

## Details

Edge density equals the sum of all edges divided by total landscape
area. The count_boundary parameter is passed to vm_l_te.

Note: The default differs from landscapemetrics (default: FALSE) because
vector polygon boundaries are explicit geometric features. Set
count_boundary=FALSE for direct comparison with landscapemetrics
results.

## Examples

``` r
vm_l_ed(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    ed     5522.
vm_l_ed(vector_landscape, count_boundary = FALSE)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    ed     4189.
```
