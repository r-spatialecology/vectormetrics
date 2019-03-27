#' @title the number of disjunct core area in the whole landscape(vector data)
#' @description This function allows you to calculate the number of disjunct core areas in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param core_distance the fixed distance to the edge of the patch
#' @return  the returned calculated number of core area is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_ndca(landscape, "landcover", core_distance = 1)

#' @export
vm_l_ndca <- function(landscape, class, core_distance){
  dcore <- vm_p_ncore(landscape, class, core_distance)

  dcore_l <- sum(dcore$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "ndca",
    value = as.double(dcore_l)
  )
}
