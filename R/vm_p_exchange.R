#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @details share of the total area of the shape that is inside the equal-area circle around its centroid
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_exchange(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_exchange <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # create equal-area circles around centroid
  radius <- sqrt(landscape$area / pi)
  circles <- landscape |> geos::geos_centroid() |> geos::geos_buffer(radius) |> sf::st_as_sf()

  exchange_index <- sapply(1:nrow(landscape), function(i){
    circle_intsc <- circles[i, ] |> geos::geos_intersection(landscape[i, ]) |> sf::st_as_sf()
    circle_intsc[, class] <- landscape[i, class, drop = TRUE]
    circle_intsc$area <- sum(vm_p_area(circle_intsc, class)$value * 10000)
    circle_intsc$area / landscape$area[i]
  })

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("exchange_index", nrow(landscape)),
    value = as.double(exchange_index)
  ))
}
