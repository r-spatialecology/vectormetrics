#' @title Sphercity(vector data)
#'
#' @description Calculate sphercity
#' @details ratio between radius of maximum inscribed circle and minimum circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_sph(vector_landscape, "class")
#' @export

vm_p_sph <- function(landscape, class) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, class]

  # calculate the radius of minimum circumscribing circle
  landscape$circum <- vm_p_circum(landscape, class)$value / 2

  # calculate the radius of maximum inscribed circle
  insc_circle_area <- landscape |> sf::st_geometry() |> sf::st_inscribed_circle() |> sf::st_area()
  landscape$inscr <- sqrt(insc_circle_area[1:nrow(landscape)] / pi)

  # ratio of area of polygon and its MABR
  sph_index <- landscape$inscr / landscape$circum

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("sph_index", nrow(landscape)),
    value = as.double(sph_index)
  ))
}
