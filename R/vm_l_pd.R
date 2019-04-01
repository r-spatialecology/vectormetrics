#' @title the patch density in the whole landscape(vector data)
#' @description This metric is based on categorical landscape in vector data format. The density is the number of patches of the whole landscape
#' relative to the total landscape area. Then the number is standardised, so that the comparison among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated density of each class is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_pd(vector_landscape, "class")

#' @export
vm_l_pd <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  pa_num <- length(area$class)
  A <- sum(area$value*10000)
  pd <- pa_num / A * 10000 * 100
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "pd",
    value = as.double(pd)
  )
}
