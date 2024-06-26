#' @title Core area index(vector data)
#'
#' @description This function allows you to calculate the ratio of the core area and the area in square meters.
#' Core area is defined as an area that within the patch and its edge is a fixed value from the boundary of the patch.
#' The index describes the percentage of a patch that is core area.
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_cai(vector_patches, "class", "patch", edge_depth = 0.8)
#' @export

vm_p_cai <- function(landscape, class_col = NULL, patch_col = NULL, edge_depth) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }
  
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  area <- vm_p_area(landscape, class_col, patch_col)
  core <- vm_p_core(landscape, class_col, patch_col, edge_depth)
  cai <- core$value / area$value * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(core)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("cai", nrow(core)),
    value = as.double(cai)
  ))
}
