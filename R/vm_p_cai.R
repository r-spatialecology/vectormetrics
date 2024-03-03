#' @title Core area index(vector data)
#'
#' @description This function allows you to calculate the ratio of the core area and the area in square meters.
#' Core area is defined as an area that within the patch and its edge is a fixed value from the boundary of the patch.
#' The index describes the percentage of a patch that is core area.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_cai(vector_patches, "class", "patch", edge_depth = 0.8)
#' @export

vm_p_cai <- function(landscape, class = NA, patch_id = NA, edge_depth) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }
  
  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  area <- vm_p_area(landscape, class, patch_id)
  core <- vm_p_core(landscape, class, patch_id, edge_depth)
  cai <- core$value / area$value * 100

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(core)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("cai", nrow(core)),
    value = as.double(cai)
  ))
}
