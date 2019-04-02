#' @title Effective Mesh Size (vector data)

#' @description This function helps to analyse the patch structure
#' the calculate process is, each patch is squared before the sums for each class i are calculated
#' and the sum is standardized by the total landscape area. it is a aggregation metric.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated values are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_mesh(vector_landscape, "class")

#' @export
vm_c_mesh <- function(landscape, class){

  # calculate the area of all the patches and then square it
  area <- vm_p_area(landscape, class)
  area$value <- area$value * 10000
  area$value_2 <- (area$value)^2

  area_sum <- stats::aggregate(area$value_2,
                               by= list(area$class),
                               sum,
                               na.rm = TRUE)

  A <- sum(area$value)

  area_sum$mesh <- area_sum[, 2]/A/10000

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(area_sum[, 1]),
    id = as.integer(NA),
    metric = "MESH",
    value = as.double(area_sum[, 2])
  )
}
