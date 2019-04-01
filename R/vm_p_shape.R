#' @title Shape index(vector data)
#'
#' @description This function allows you to calculate the shape index, which is
#' the ratio between the actual perimeter of the patch and the hypothetical minimum perimeter of the patch.
#' The minimum perimeter equals the perimeter if the patch would be maximally compact. That means,
#' the perimeter of a circle with the same area of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated indices of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_shape(vector_landscape, "class")
#' @export

# shape
vm_p_shape <- function(landscape, class) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }


  peri <- vm_p_perim(landscape, class)

  # shape metric is the ratio between actual perimeter and the hypothetical minimum perimeter of the patch
  # the hypothetical minimum perimeter of the patch is perimeter of the circle with same amount of area
  # pi * R^2 = area, R = sqrt(area/pi), hypothetical minimum perimeter = 2 * pi * R
  area <- vm_p_area(landscape, class)
  area$value <- area$value * 10000
  shape <- peri$value / (2 * pi * sqrt(area$value / pi))

  tibble::tibble(
    level = "patch",
    class = as.integer(area$class),
    id = as.integer(1:nrow(area)),
    metric = "shape",
    value = as.double(shape)
  )
}
