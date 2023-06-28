#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio of the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_full_idx(vector_landscape, "class")
#' @export

vm_p_full_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # caluclate area of polygons
  landscape$area = vm_p_area(landscape, class)$value * 10000

  progress_bar = txtProgressBar(min = 0, max = nrow(landscape), style = 3, char = "=")
  for (i in 1:nrow(landscape)) {
    geom = landscape[i, ]
    neigh_area = geom$area * 0.01
    radius = sqrt(neigh_area / pi)
    buffers = geom %>%
      st_sample(size = 10000, type = "regular") %>%
      st_set_crs(st_crs(geom)) %>%
      st_buffer(radius)

    buffers$fullness = (st_intersection(buffers, geom) %>% st_area()) / neigh_area
    landscape$fullness[i] = mean(buffers$fullness)
    setTxtProgressBar(progress_bar, value = i)
  }
  close(progress_bar)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "full_index",
    value = as.double(landscape$fullness / 0.958)
  )
}
