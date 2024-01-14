#' @title Equivalent rectangular index(vector data)
#'
#' @description Calculate Equivalent rectangular index (ERI)
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  ratio between perimeter of equal-area rectangle of shape and perimeter of shape
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_sq_idx(vector_landscape, "class")
#' @export

vm_p_eri <- function(landscape, class){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, class]

  perim <- vm_p_perim(landscape, class)$value
  area <- vm_p_area(landscape, class)$value * 10000
  mabr_area <- landscape |> sf::st_minimum_rotated_rectangle() |> vm_p_area(class)
  mabr_perim <- landscape |> sf::st_minimum_rotated_rectangle() |> vm_p_perim(class)

  ear_perim <- sqrt(area / (mabr_area$value * 10000)) * mabr_perim$value
  eri <- ear_perim / perim

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    metric = rep("ERI", nrow(landscape)),
    value = as.double(eri)
  ))
}
