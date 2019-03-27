
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
#' vm_p_circle(landscape, "landcover")
#' @export


vm_p_circle <- function(landscape, class) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- dplyr::select(landscape, class, "geometry")

  # extract the multipolygon, cast to single polygons (patch level)

  if(any(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    multi <- landscape[sf::st_geometry_type(landscape)=="MULTIPOLYGON", ]
    landscape_multi<- sf::st_cast(multi, "POLYGON", warn = FALSE)
    landscape_poly <- landscape[sf::st_geometry_type(landscape)=="POLYGON", ]
    landscape <- rbind(landscape_multi, landscape_poly)
  }

  # cast then to MULTILINESTRING
  landscape_cast <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE) # MH: add warn = FALSE to supress warnings

  # create a new vector to storage all the output of "for" loop
  dis_max <- c()

  # for obtaining the maximal distance of the points on the edge of each polygons,
  # that is the perimeter of the smallest circumscribing
  for (i in 1:nrow(landscape_cast)) {
    landscape_point <- sf::st_cast(landscape_cast[1, ], "POINT", warn = FALSE) # MH: add warn = FALSE to supress warnings
    dis <- sf::st_distance(landscape_point, by_element = F)
    dis_max[i] <- max(dis)
  }


  circle_area <- vm_p_area(landscape, class)
  circum_area <- pi * (dis_max / 2)^2
  landscape_cast$circle <- 1 - (circle_area$value*10000/ circum_area)

  # return result tibble
  class_ids <- dplyr::pull(sf::st_set_geometry(landscape, NULL), class)
  if (class(class_ids) == "factor"){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape_cast)),
    metric = "circle",
    value = as.double(landscape_cast$circle)
  )

}
