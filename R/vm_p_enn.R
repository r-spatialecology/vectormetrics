#' @title Euclidean Nearest-Neighbor Distance(vector data)
#'
#' @description This function allows you to calculate the distance to the nearest neighbouring patch of the same class in meters
#' The distance is measured from edge-to-edge.
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_enn(vector_patches, "class", "patch")
#' @export

vm_p_enn <- function(landscape, class_col = NULL, patch_col = NULL) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # cast then to MULTILINESTRING
  landscape_poly <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split=FALSE)

  # create a vector to storage all the output of  "for" loop
  enn <- vector(mode = "numeric", length = nrow(landscape_poly))
  for (i in seq_len(nrow(landscape_poly))) {
    c <- landscape_poly[i, ] |>
      sf::st_drop_geometry() |>
      dplyr::pull(!!class_col) |>
      as.character()

    landscape_point_1 <- sf::st_cast(landscape_poly[i, ], "POINT", warn = FALSE)
    landscape_point_2 <- sf::st_cast(landscape_poly[-i, ], "POINT", warn = FALSE)

    # create another vector to storage all the output of this "for" loop
    min_dis <- vector(mode = "numeric", length = nrow(landscape_point_1))
    for (k in seq_len(nrow(landscape_point_1))) {
      # obtain the distance of each point of the processing patch(polygon)
      # to all the points of other polygons belonging to the same class
      dis <- sf::st_distance(landscape_point_1[k, ], landscape_point_2[landscape_point_2[, class_col, drop = TRUE] == c, ])
      
      # the closest distance of each point of the patch to all the points of other patches
      min_dis[k] <- min(dis)
    }

    # the distance of a patch to the nearest patch belonging to the same class
    enn[i] <- min(min_dis)
  }

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("enn", nrow(landscape)),
    value = as.double(enn)
  ))
}
