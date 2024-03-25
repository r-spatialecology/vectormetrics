#' @title Exchange Index(vector data)
#'
#' @description Calculate Exchange Index
#' @details share of the total area of the shape that is inside the equal-area circle around its centroid
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_exchange(vector_patches, "class", "patch")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_exchange <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class_col, patch_col)$value * 10000

  # create equal-area circles around centroid
  radius <- sqrt(landscape$area / pi)
  circles <- landscape |> geos::geos_centroid() |> geos::geos_buffer(radius) |> sf::st_as_sf()

  exchange_index <- sapply(1:nrow(landscape), function(i){
    circle_intsc <- circles[i, ] |> geos::geos_intersection(landscape[i, ]) |> sf::st_as_sf()
    circle_intsc[, class_col] <- landscape[i, class_col, drop = TRUE]
    circle_intsc$area <- sum(vm_p_area(circle_intsc, class_col)$value * 10000)
    circle_intsc$area / landscape$area[i]
  })

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("exchange_index", nrow(landscape)),
    value = as.double(exchange_index)
  ))
}
