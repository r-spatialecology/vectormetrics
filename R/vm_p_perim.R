#' @title The perimeter of each patches(vector data)
#'
#' @description This function allows you to calculate the perimeter of each patches in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated perimeter of all patches is in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' st_p_area(vector_landscape, "class")
#' @export

vm_p_perim <- function(landscape, class) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  # cast then to multilinestring
  landscape_cast <- sf::st_boundary(landscape)

  # calculate the length of each multilinestring, that is the perimeter of each polygon as well
  landscape_cast$perim <- sf::st_length(landscape_cast)

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("perim", nrow(landscape)),
    value = as.double(landscape_cast$perim)
  ))
}
