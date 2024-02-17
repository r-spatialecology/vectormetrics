#' @title the patch density in the whole landscape(vector data)
#' @description This metric is based on categorical landscape in vector data format. The density is the number of patches of the whole landscape
#' relative to the total landscape area. Then the number is standardised, so that the comparison among different landscape is possible.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_pd(vector_landscape, "class")
#' @export

vm_l_pd <- function(landscape, class){
  area <- vm_p_area(landscape, class)
  pa_num <- length(area$class)
  area_sum <- sum(area$value * 10000)
  pd <- pa_num / area_sum * 10000 * 100

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "pd",
    value = as.double(pd)
  ))
}
