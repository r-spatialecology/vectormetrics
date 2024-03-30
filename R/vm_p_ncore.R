#' @title the number of disjunct core area(vector data)
#'
#' @description This function allows you to calculate the number of disjunct core areas of all patches
#' Core area is defined as an area that within the patch and its edge is a fixed value from the boundary of the patch.
#' Disjunct core area is defined as a new discrete area(patch), which is a sub-part of core area
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_core(vector_patches, "class", "patch", edge_depth = 0.8)
#' @export

vm_p_ncore <- function(landscape, class_col = NULL, patch_col = NULL, edge_depth){
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  #create the core areas using st_buffer with a negetive distance to the edge of polygons
  core_area <- geos::geos_buffer(landscape, dist = -edge_depth) |> sf::st_as_sf()

  # the number of polygons(Disjunct core areas) in each patch
  core_area$core_area_number <- sapply(core_area$geometry, length)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("ncore", nrow(landscape)),
    value = as.double(core_area$core_area_number)
  ))

}
