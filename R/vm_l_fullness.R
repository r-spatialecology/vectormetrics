#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @details ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' @param landscape the input landscape image,
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_l_fullness(vector_landscape, n = 10000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_l_fullness <- function(landscape, n = 10000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.")
  }
  if (n < 1000){
    warning("Low number of local neighbourhoods, result might be biased.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  if (nrow(landscape) > 1){
    union <- landscape[1, ]
    for (i in 2:nrow(landscape)){
      union <- geos::geos_union(landscape[i, ], union)
    }
    landscape <- sf::st_as_sf(union)
  }

  # caluclate area of polygons
  landscape$area <- vm_p_area(landscape)$value * 10000

  neigh_area <- landscape$area * 0.01
  radius <- sqrt(neigh_area / pi)
  buffers <- get_igp(landscape, n) |> geos::geos_buffer(radius)
  buffers$fullness <- (
      buffers |> geos::geos_intersection(geos::as_geos_geometry(landscape)) |> geos::geos_area()
    ) / neigh_area
  landscape$fullness <- mean(buffers$fullness)

  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "full_index",
    value = as.double(landscape$fullness / 0.958)
  ))
}
