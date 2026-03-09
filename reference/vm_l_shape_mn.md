# The mean value of Shape index of landscape (vector data)

This function allows you to calculate the mean value of shape index of
all patches in a categorical landscape in vector data format shape index
is the ratio between the actual perimeter of the patch and the
hypothetical minimum perimeter of the patch. The minimum perimeter
equals the perimeter if the patch would be maximally compact. That
means, the perimeter of a circle with the same area of the patch.

## Usage

``` r
vm_l_shape_mn(landscape)
```

## Arguments

- landscape:

  the input landscape image,

## Value

the returned calculated mean value of each class is in column "value",
and this function returns also some important information such as level
and metric name, Moreover, class number and the "id" column, although
both are "NA" here in the landscape level

## Examples

``` r
vm_l_shape_mn(vector_landscape)
#> # A tibble: 1 × 5
#>   level     class id    metric   value
#>   <chr>     <chr> <chr> <chr>    <dbl>
#> 1 landscape NA    NA    shape_mn  4.87
```
