#' @title Area of the convex hull(vector data)
#'
#' @description Calculate area of the convex hull of the polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  area of the convex hull of the polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' @export

vm_p_conva <- function(landscape, class) {
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

  convex = sf::st_convex_hull(landscape)
  convex_area = vm_p_area(convex, class)$value * 10000

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids[, 1]),
    id = as.integer(1:nrow(landscape)),
    metric = "convex_area",
    value = as.double(convex_area)
  )
}
