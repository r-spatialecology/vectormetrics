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
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  # create a vector to store nearest neighbor distances
  enn <- vector(mode = "numeric", length = nrow(landscape))
  
  for (i in seq_len(nrow(landscape))) {
    # get class of current patch
    patch_class <- landscape[[class_col]][i]
    
    # find other patches of same class
    same_class <- landscape[[class_col]] == patch_class & seq_len(nrow(landscape)) != i
    
    if (any(same_class)) {
      # calculate edge-to-edge distances to all other patches of same class
      distances <- sf::st_distance(landscape[i, ], landscape[same_class, ])
      enn[i] <- min(distances)
    } else {
      enn[i] <- NA_real_
    }
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
