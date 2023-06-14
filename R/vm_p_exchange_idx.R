#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return share of the total area of the shape that is inside the equal-area circle about its centroid
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_exchange_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- get_patches.sf(landscape, class, 4)

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # create equal-area circles around centroid
  radius <- sqrt(landscape$area / pi)
  circles <- landscape |> sf::st_centroid() |> sf::st_buffer(radius)

  exchange_index <- sapply(seq_along(1:nrow(landscape)), function(i){
    circle_intsc <- circles[i, ] |> sf::st_intersection(landscape[i, ])
    circle_intsc$area <- sum(vm_p_area(circle_intsc, class)$value * 10000)
    circle_intsc$area / landscape$area[i]
  })

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class]

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = landscape$patch,
    #id = as.integer(1:nrow(landscape)),
    metric = "exchange_index",
    value = as.double(exchange_index)
  )
}
