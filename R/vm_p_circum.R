#' @title Diameter of smallest circumscribing circle(vector data)
#'
#' @description Calculate diameter of smallest circumscribing circle
#' @details diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_circum(vector_patches, "class", "patch")
#' @export

vm_p_circum <- function(landscape, class = NA, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  landscape <- sf::st_cast(landscape, "MULTIPOINT", warn = FALSE, do_split = FALSE)

  # compute max distant for each MULTIPOINT, which is the diameter of a circle around each patch
  dis <- c()
  dis_max <- sapply(seq_len(nrow(landscape)), function(i){
    landscape_point <- sf::st_cast(landscape[i, ], "POINT", warn = FALSE)

    for (i in seq_len(nrow(landscape_point))){
      point <- landscape_point[i,]
      dis <- c(dis, geos::geos_distance(point, landscape_point))
    }
    max(dis)
  })

  # return result tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("circum_diam", nrow(landscape)),
    value = as.double(dis_max)
  ))
}
