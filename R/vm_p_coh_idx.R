#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_coh_idx(vector_landscape, "class")
#' @export

vm_p_coh_idx <- function(landscape, class, n = 1000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # calculate average distance-squared among points in equal-area circle
  eac_sq_dist <- sqrt(landscape$area / pi)

  for (i in 1:nrow(landscape)) {
    geom <- landscape[i, ]
    points <- get_igp(geom, n) |> sf::st_as_sf()

    m <- c()
    for (j in 1:length(points)){
      point = points[j,]
      m <- c(m, geos::geos_distance(point, points))
    }
    m[m == 0] <- NA
    landscape$avg_distance <- mean(m, na.rm = TRUE)
  }
  cohesion_index <- eac_sq_dist / landscape$avg_distance
  cohesion_index <- ifelse(cohesion_index > 1, 1, cohesion_index)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "cohesion_index",
    value = as.double(cohesion_index)
  )
}
