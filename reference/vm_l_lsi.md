# Landscape shape index (vector data)

This function allows you to calculate the ratio between the actual edge
length and the hypothetical minimum edge length in a categorical
landscape in vector data format. The minimum edge length equals the edge
length if the landscape would be maximally aggregated into a circle.

## Usage

``` r
vm_l_lsi(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated index are in column "value", and this function
returns also some important information such as level and metric name,
Moreover, class number and the "id" column, although both are "NA" here
in the landscape level

## Details

LSI is calculated as: LSI = TE / (2 \* pi \* sqrt(A/pi)) where TE is the
total edge (in meters) and A is the total landscape area (in square
meters). This uses circle standardization, which is more natural for
vector data. An LSI of 1 indicates a perfectly circular landscape. The
boundary is included in the calculation (count_boundary=TRUE).

## Examples

``` r
vm_l_lsi(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric value
#>   <chr>     <chr> <chr> <chr>  <dbl>
#> 1 landscape NA    NA    lsi     4.67
```
