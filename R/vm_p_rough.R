#' @title Roughness index(vector data)
#'
#' @description Calculate Roughness index (RI)
#' @details to be added...
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of boundary points to generate
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_rough(vector_landscape, "class", n = 100)
#' @references
#' Basaraner, M., & Cetinkaya, S. (2017). Performance of shape indices and classification schemes for characterising perceptual shape complexity of building footprints in GIS.
#' International Journal of Geographical Information Science, 31(10), 1952–1977. https://doi.org/10.1080/13658816.2017.1346257
#' @export

vm_p_rough <- function(landscape, class, n = 100){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  for (i in seq_len(nrow(landscape))){
    shape <- landscape[i, ]
    ibp <- get_ibp(shape, n)
    cent <- geos::geos_centroid(shape)

    ibp_dist <- geos::geos_distance(ibp, cent)
    landscape$ibp_dist[i] <- mean(ibp_dist)
  }

  perim <- vm_p_perim(landscape, class)$value
  area <- vm_p_area(landscape, class)$value * 10000

  roughness <- (landscape$ibp_dist^2) / (area + perim^2) * 42.62

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("roughness", nrow(landscape)),
    value = as.double(roughness)
  ))
}
