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
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  landscape <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE)

  # compute max distant for each MULTIPOINT, which is the diameter of a circle around each patch
  dis <- c()
  dis_max <- sapply(seq_len(nrow(landscape)), function(i){
    landscape_point <- sf::st_cast(landscape[i, ], "POINT", warn = FALSE)

    for (i in seq_len(nrow(landscape_point))){
      point <- landscape_point[i,]
      dis <- c(dis, geos::geos_distance(point, landscape_point))
    }
    max(dis)
  })

  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }
  
  # return result tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("circum_diam", nrow(landscape)),
    value = as.double(dis_max)
  ))
}
