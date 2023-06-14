#' @title Diameter of smallest circumscribing circle(vector data)
#'
#' @description Calculate diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  diameter of equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' @export

vm_p_circum <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- get_patches.sf(landscape, class, 4)

  landscape <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE)

  # compute max distant for each MULTIPOINT, which is the diameter of a circle around each patch
  dis_max <- sapply(seq_along(1:nrow(landscape)), function(i){
    landscape_point <- sf::st_cast(landscape[i, ], "POINT", warn = FALSE)
    dis <- sf::st_distance(landscape_point, by_element = F)
    max(dis)
  })

  class_ids <- sf::st_set_geometry(landscape, NULL)[, class]
  # return result tibble
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = landscape$patch,
    #id = as.integer(1:nrow(landscape_cast)),
    metric = "circum_diam",
    value = as.double(dis_max)
  )
}
