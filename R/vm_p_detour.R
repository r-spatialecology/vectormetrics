#' @title Detour Index(vector data)
#'
#' @description Calculate Detour Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of convex hull of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_detour <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)

  if(any(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    multi <- landscape[sf::st_geometry_type(landscape)=="MULTIPOLYGON", ]
    landscape_multi<- sf::st_cast(multi, "POLYGON", warn = FALSE)
    landscape_poly <- landscape[sf::st_geometry_type(landscape)=="POLYGON", ]
    landscape <- rbind(landscape_multi, landscape_poly)
  }

  # area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # calculate the length of each perimeter hull
  landscape$convex_perim <- vm_p_convp(landscape, class)$value

  # ratio of perimeter of polygon and its convex hull
  detour_index <- vm_p_circlep(landscape, class)$value / landscape$convex_perim

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids[, 1]),
    id = as.integer(1:nrow(landscape)),
    metric = "detour_index",
    value = as.double(detour_index)
  )
}
