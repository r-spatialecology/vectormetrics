#' @title fractal dimension index(vector data)
#'
#' @description This function allows you to calculate index fractal dimension index.
#' The index is based on the patch perimeter and the patch area and describes the patch complexity.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated indice of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_frac(vector_landscape, "class")
#' @export

# frac
vm_p_frac <- function(landscape, class) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # calculating the metric frac
  area <- vm_p_area(landscape, class)
  peri <- vm_p_perim(landscape, class)
  frac <- 2 * log(peri$value) / log(area$value)

  # return results tibble
  tibble::tibble(
    level = "patch",
    class = as.integer(area$class),
    id = as.integer(1:nrow(area)),
    metric = "para",
    value = as.double(frac)
  )
}
