#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_proxim_idx(vector_landscape, "class")
#' @export

vm_p_proxim_idx <- function(landscape, class, n = 1000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  progress_bar <- txtProgressBar(min = 0, max = nrow(landscape), style = 3, char = "=")
  for (i in seq_len(nrow(landscape))){
    shape <- landscape[i, ]
    igp <- get_igp(shape, n)
    cent <- geos::geos_centroid(shape)

    igp_dist <- geos::geos_distance(igp, cent)
    landscape$igp_dist[i] <- mean(igp_dist)
    setTxtProgressBar(progress_bar, value = i)
  }
  close(progress_bar)

  radiuses = vm_p_circlep(landscape, class)$value / (2 * pi) * 0.66
  proximity = radiuses / landscape$igp_dist

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("proximity_index", nrow(landscape)),
    value = as.double(proximity)
  ))
}
