#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @details ratio between the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_fullness(vector_patches, "class", "patch", 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_fullness <- function(landscape, class = NA, patch_id = NA, n = 10000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }
  if (n < 1000){
    warning("Low number of local neighbourhoods, result might be biased.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  # caluclate area of polygons
  area <- vm_p_area(landscape, class, patch_id)$value * 10000
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
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("full_index", nrow(landscape)),
    value = as.double(landscape$fullness / 0.958)
  ))
}
