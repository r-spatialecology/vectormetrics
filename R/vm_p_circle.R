
#' @title Ratio between the patch area and the smallest circumscribing circle of the patch.
#'
#' @description This function allows you to calculate the ratio between the patch area and the smallest circumscribing circle of the patch.
#' The diameter of the smallest circumscribing circle is the The distance between the two farthest points on the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the function returns the calculated ratio of all patches in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_circle(vector_landscape, "class")
#' @export


vm_p_circle <- function(landscape, class) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- sf::st_cast(landscape, "POLYGON", warn = FALSE)

  # cast then to MULTILINESTRING
  landscape_cast <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE)

  # create empty variable to be filled
  dis_max <- vector("double", length = nrow(landscape_cast))

  for (i in seq_len(nrow(landscape_cast))) {
    landscape_point <- sf::st_cast(landscape_cast[i, ], "POINT", warn = FALSE)
    dis <- sf::st_distance(landscape_point, by_element = F)
    dis_max[i] <- max(dis)
  }

  circle_area <- vm_p_area(landscape, class)
  circum_area <- pi * (dis_max / 2)^2
  landscape_cast$circle <- 1 - (circle_area$value*10000/ circum_area)

  # return result tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids[, 1]),
    id = as.integer(1:nrow(landscape_cast)),
    metric = "circle",
    value = as.double(landscape_cast$circle)
  )

}
