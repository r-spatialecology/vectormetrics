# Landscape shape index (vector data)

This function allows you to calculate the ratio between the actual edge
length of class i and the hypothetical minimum edge length of class i in
a categorical landscape in vector data format. The minimum edge length
equals the edge length if class i would be maximally aggregated into a
circle.

## Usage

``` r
vm_c_lsi(landscape, class_col)
```

## Arguments

- landscape:

  the input landscape image,

- class_col:

  the name of the class column of the input landscape

## Value

the returned calculated index are in column "value", and this function
returns also some important information such as level, class number and
metric name. Moreover, the "id" column, although it is just NA here at
class level. we need it because the output struture of metrics at class
level should correspond to patch level one by one, and then it is more
convinient to combine metric values at different levels and compare
them.

## Details

LSI is calculated as: LSI = TE / (2 \* pi \* sqrt(CA/pi)) where TE is
the total edge (in meters) and CA is the class area (in square meters).
This uses circle standardization, which is more natural for vector data.
An LSI of 1 indicates a perfectly circular class. Note: This differs
from landscapemetrics which uses square standardization.

## Examples

``` r
vm_c_lsi(vector_landscape, "class")
#> # A tibble: 3 × 5
#>   level class id    metric value
#>   <chr> <chr> <chr> <chr>  <dbl>
#> 1 class 1     NA    lsi     5.06
#> 2 class 2     NA    lsi     4.76
#> 3 class 3     NA    lsi     4.80
```
