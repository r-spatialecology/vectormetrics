#' @title Elongation(vector data)
#'
#' @description Calculate elongation of shape
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between major and minor axis length
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_elong_idx(vector_landscape, "class")
#' @export

vm_p_elong_idx <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  # calculate the length of polygon's axes
  axes <- get_axes(landscape, class)

  elong_index <- 1 - (axes$minor / axes$major)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "elong_index",
    value = as.double(elong_index)
  )
}
