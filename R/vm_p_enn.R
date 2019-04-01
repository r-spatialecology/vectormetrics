#' @title Euclidean Nearest-Neighbor Distance(vector data)
#'
#' @description This function allows you to calculate the distance to the nearest neighbouring patch of the same class in meters
#' The distance is measured from edge-to-edge.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated distances of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_enn(vector_landscape, "class")

#' @export
# enn
vm_p_enn <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- dplyr::select(landscape, class, "geometry")
  names(landscape) <- c("landcover", "geometry")

  # extract the multipolygon, cast to single polygons (patch level)

  if(any(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    multi <- landscape[sf::st_geometry_type(landscape)=="MULTIPOLYGON", ]
    landscape_multi<- sf::st_cast(multi, "POLYGON", warn = FALSE)
    landscape_poly <- landscape[sf::st_geometry_type(landscape)=="POLYGON", ]
    landscape <- rbind(landscape_multi, landscape_poly)
  }

  # cast then to MULTILINESTRING
  landscape_poly <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split=F)

  # create a vector to storage all the output of  "for" loop
  enn <- c()
  for (i in 1:nrow(landscape_poly)) {

    # obtain which class the processing polygon is
    c <- sf::st_set_geometry(landscape_poly[i, ], NULL)
    c <- as.numeric(c)

    # one is, cast the MULTIPOINT of the processing polygon into POINT,
    # another is, cast the MULTIPOINT of all other polygons into POINT.
    landscape_point_1 <- sf::st_cast(landscape_poly[i, ], "POINT", warn = FALSE) # center patch # MH: add warn = FALSE to supress warnings
    landscape_point_2 <- sf::st_cast(landscape_poly[-i, ], "POINT", warn = FALSE) # MH: add warn = FALSE to supress warnings

    # create another vector to storage all the output of this "for" loop
    min_dis <- c()
    for (k in 1:nrow(landscape_point_1)) {

      # obtain the distance of each point of the processing patch(polygon)
      # to all the points of other polygons belonging to the same class
      dis <- sf::st_distance(landscape_point_1[k, ], landscape_point_2[landscape_point_2$landcover == c, ])

      min_dis[k] <- min(dis) # the closest distance of each point of the patch to all the points of other patches
    }

    enn[i] <- min(min_dis) # the distance of a patch to the nearest patch belonging to the same class
  }

  # return results tibble
  class_ids <- dplyr::pull(sf::st_set_geometry(landscape, NULL), class)
  if (class(class_ids) == "factor"){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape_poly)),
    metric = "enn",
    value = as.double(enn)
  )
}
