#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return sqrt(4 * area / pi) / perimeter
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_comp_idx(vector_landscape, "class")
#' @export

vm_p_comp_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class)$value * 10000

  # calculate the perimeter of polygons
  landscape$perim <- vm_p_perim(landscape, class)$value

  # ratio of perimeter of convex hull and polygon perimeters
  comp_index <- (4 * pi * landscape$area) / landscape$perim ^ 2

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("comp_index", nrow(landscape)),
    value = as.double(comp_index)
  ))
}
