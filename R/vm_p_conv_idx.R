#' @title Convexity(vector data)
#'
#' @description Calculate convexity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of convex hull and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_conv_idx(vector_landscape, "class")
#' @export

vm_p_conv_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if (!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))) {
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")) {
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # calculate the perimeter of polygons
  landscape$perim <- vm_p_perim(landscape, class)$value

  # calculate the perimeter of convex hull
  landscape$conv_perim <- vm_p_convp(landscape, class)$value

  # ratio of perimeter of convex hull and polygon perimeters
  conv_index <- landscape$conv_perim / landscape$perim

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("conv_index", nrow(landscape)),
    value = as.double(conv_index)
  ))
}
