#' @title Fullness Index(vector data)
#'
#' @description Calculate Fullness Index
#' @details ratio between the average fullness of small neighbourhoods (1% of area) in the shape and in its equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param n number of local neighbourhoods to consider in calculating fullness
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_c_fullness(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_c_fullness <- function(landscape, class, n = 10000) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }
  if (n < 1000){
    warning("Low number of local neighbourhoods, result might be biased.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape |> dplyr::group_by_at(class) |> dplyr::summarise(geometry = sf::st_union(geometry)) |> dplyr::ungroup()
  fullness <- vm_p_fullness(landscape, class, n)$value

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("class", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(NA),
    metric = "full_index",
    value = as.double(fullness / 0.958)
  ))
}