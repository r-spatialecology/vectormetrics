#' @title Range Index(vector data)
#'
#' @description Calculate Range Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between diameter of equal-area circle and diameter of smallest circumscribing circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_range_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- get_patches.sf(landscape, class, 4)

  # calculate the diameter of equal-area circle
  landscape$circle_diam <- vm_p_circlep(landscape, class)$value / pi

  # calculate the diameter of smallest circumscribing circle
  landscape$circum_diam <- vm_p_circum(landscape, class)$value

  # ratio of perimeter of equal-area circle and its convex hull
  range_index <- landscape$circle_diam / landscape$circum_diam

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class]

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = landscape$patch,
    #id = as.integer(1:nrow(landscape)),
    metric = "range_index",
    value = as.double(range_index)
  )
}
