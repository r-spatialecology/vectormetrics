#' @title Rectangularity(vector data)
#'
#' @description Calculate rectangularity
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between area of shape and its minimum area bounding rectangle (MABR)
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_rect_idx(vector_landscape, "class")
#' @export

vm_p_rect_idx <- function(landscape, class) {
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

  # calculate the area of MABR
  mabr <- sf::st_minimum_rotated_rectangle(landscape)
  landscape$mabr_area <- vm_p_area(mabr, class)$value * 10000

  # ratio of area of polygon and its MABR
  rect_index <- landscape$area / landscape$mabr_area

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "rect_index",
    value = as.double(rect_index)
  )
}
