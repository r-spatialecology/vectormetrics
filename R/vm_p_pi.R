#' @title Perimeter Index(vector data)
#'
#' @description Calculate Perimeter Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area circle and perimeter of polygon
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_pi <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  # select geometry column for spatial operations and the column that identifies
  # the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- get_patches.sf(landscape, class, 4)

  # calculate the length of each perimeter
  landscape$perim <- vm_p_perim(landscape, class)$value
  landscape$circle_perim <- vm_p_circlep(landscape, class)$value

  # ratio of perimeter of equal-area circle and polygon perimeters
  perim_index <- landscape$circle_perim / landscape$perim

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids[, 1]),
    id = landscape$patch,
    #id = as.integer(1:nrow(landscape)),
    metric = "perim_index",
    value = as.double(perim_index)
  )
}
