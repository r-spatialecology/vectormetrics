#' @title Diameter of smallest circumscribing circle(vector data)
#'
#' @description Calculate diameter of smallest circumscribing circle
#' @details diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' get_circum_diam(vector_patches, "class", "patch")
#' @export

get_circum_diam <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  landscape <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE)

  # compute max distant for each MULTIPOINT, which is the diameter of a circle around each patch
  dis_max <- sapply(seq_len(nrow(landscape)), function(i){
    landscape_point <- sf::st_cast(landscape[i, ], "POINT", warn = FALSE)
    n_points <- nrow(landscape_point)

    dis <- vector(mode = "numeric", length = n_points^2)
    for (j in seq_len(nrow(landscape_point))){
      point <- landscape_point[j, ]
      dis[((j - 1) * n_points + 1):(j * n_points)] <- geos::geos_distance(point, landscape_point)
    }
    max(dis)
  })

  # return result tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("circum_diam", nrow(landscape)),
    value = as.double(dis_max)
  ))
}
