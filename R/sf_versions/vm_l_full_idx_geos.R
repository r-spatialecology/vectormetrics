#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return  ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_fullness(vector_landscape, "class")
#' @export

vm_l_full_idx_geos <- function(landscape, class, n = 10000) {
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
  landscape <- sf::st_union(landscape) |> sf::st_as_sf()
  landscape$class = 1

  # caluclate area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  neigh_area <- landscape$area * 0.01
  radius <- sqrt(neigh_area / pi)
  buffers <- get_igp(landscape, n) |> geos::geos_buffer(radius)
  buffers$fullness <- (geos::geos_intersection(buffers, landscape) |> geos::geos_area()) / neigh_area
  landscape$fullness <- mean(buffers$fullness)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "full_index",
    value = as.double(landscape$fullness / 0.958)
  )
}
