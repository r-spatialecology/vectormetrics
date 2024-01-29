#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @details ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_proxim(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_proxim <- function(landscape, class, n = 1000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  progress_bar <- utils::txtProgressBar(min = 0, max = nrow(landscape), style = 3, char = "=")
  for (i in seq_len(nrow(landscape))){
    shape <- landscape[i, ]
    igp <- get_igp(shape, n)
    cent <- geos::geos_centroid(shape)

    igp_dist <- geos::geos_distance(igp, cent)
    landscape$igp_dist[i] <- mean(igp_dist)
    utils::setTxtProgressBar(progress_bar, value = i)
  }
  close(progress_bar)

  radiuses = vm_p_eac_perim(landscape, class)$value / (2 * pi) * 0.66
  proximity = radiuses / landscape$igp_dist

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
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
