#' @title Roughness index(vector data)
#'
#' @description Calculate Equivalent rectangular index (RI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return HERE WRITE DESCRIPTION OF METRIC
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_p_ri <- function(landscape, class, n = 100){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  for (i in 1:nrow(landscape)){
    shape <- landscape[i, ]
    ibp <- get_ibp(shape, n)
    cent <- sf::st_centroid(shape)

    ibp_dist <- sf::st_distance(ibp, cent)
    landscape$ibp_dist[i] <- mean(ibp_dist)
  }

  perim <- vm_p_perim(landscape, class)$value
  area <- vm_p_area(landscape, class)$value * 10000

  roughness <- (landscape$ibp_dist^2) / (area + perim^2) * 42.62

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "roughness",
    value = as.double(roughness)
  )
}
