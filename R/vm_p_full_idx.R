#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return  ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_full_idx(vector_landscape, "class")
#' @export

vm_p_full_idx <- function(landscape, class, n = 10000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }
  if (n < 1000){
    warning("Low number of local neighbourhoods, result might be biased.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  # caluclate area of polygons
  area <- vm_p_area(landscape, class)$value * 10000
  landscape_geos <- geos::as_geos_geometry(landscape)

  progress_bar <- utils::txtProgressBar(min = 0, max = nrow(landscape), style = 3, char = "=")
  for (i in seq_len(nrow(landscape))) {
    geom <- landscape_geos[i]
    neigh_area <- area[i] * 0.01
    radius <- sqrt(neigh_area / pi)
    buffers <- get_igp(landscape[i,], n) |> geos::geos_buffer(radius)

    fullness <- (
      buffers |> geos::geos_intersection(geom) |> geos::geos_area()
    ) / neigh_area
    landscape$fullness[i] <- mean(fullness)
    utils::setTxtProgressBar(progress_bar, value = i)
  }
  close(progress_bar)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("full_index", nrow(landscape)),
    value = as.double(landscape$fullness / 0.958)
  ))
}
