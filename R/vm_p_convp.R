#' @title Perimeter of the convex hull(vector data)
#'
#' @description Calculate perimeter of the convex hull of the polygon
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  perimeter of the convex hull of the polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' @export

vm_p_convp <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  convex <- sf::st_convex_hull(landscape)
  convex_perim <- vm_p_perim(convex, class)$value

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("convex_area", nrow(landscape)),
    value = as.double(convex_perim)
  ))
}
