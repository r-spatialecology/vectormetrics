#' @title Perimeter Index(vector data)
#'
#' @description Calculate Perimeter Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_pi <- function(landscape, class) {
  `%>%` = dplyr::`%>%`

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- landscape[, c("class", "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)

  if(any(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    multi <- landscape[sf::st_geometry_type(landscape)=="MULTIPOLYGON", ]
    landscape_multi<- sf::st_cast(multi, "POLYGON", warn = FALSE)
    landscape_poly <- landscape[sf::st_geometry_type(landscape)=="POLYGON", ]
    landscape <- rbind(landscape_multi, landscape_poly)
  }

  # area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # calculate the length of each convex hull
  landscape$perim <- vm_p_perim(landscape, class)$value

  # ratio of perimeter of polygon and its convex hull
  perim_index <- (sqrt(landscape$area / pi) * 2 * pi) / landscape$perim

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids[, 1]),
    id = as.integer(1:nrow(landscape)),
    metric = "perim_index",
    value = as.double(perim_index)
  )
}
