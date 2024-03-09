#' @title Cohesion Index(vector data)
#'
#' @description Calculate Cohesion Index
#' @details ratio of the average distance-squared among all points in an equalarea circle
#' and the average distance-squared among all points in the shape
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @param n number of grid points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_coh(vector_patches, "class", "patch", 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles. 
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_coh <- function(landscape, class_col = NULL, patch_col = NULL, n = 1000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class_col, patch_col)$value * 10000

  # calculate average distance-squared among points in equal-area circle
  eac_sq_dist <- sqrt(landscape$area / pi)

  for (i in seq_len(nrow(landscape))) {
    geom <- landscape[i, ]
    points <- get_igp(geom, n) |> sf::st_as_sf()

    n_points <- nrow(points)
    m <- vector(mode = "numeric", length = n_points^2)
    for (j in seq_len(nrow(points))){
      point <- points[j, ]
      m[((j - 1) * n_points + 1):(j * n_points)] <- geos::geos_distance(point, points)
    }
    m[m == 0] <- NA
    landscape$avg_distance <- mean(m, na.rm = TRUE)
  }
  cohesion_index <- eac_sq_dist / landscape$avg_distance
  cohesion_index <- ifelse(cohesion_index > 1, 1, cohesion_index)

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("cohesion_index", nrow(landscape)),
    value = as.double(cohesion_index)
  ))
}
