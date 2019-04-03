#' @title core area index(vector data)
#'
#' @description This function allows you to calculate the ratio of the core area and the area in square meters.
#' Core area is defined as an area that within the patch and its edge is a fixed value from the boundary of the patch.
#' The index describes the percentage of a patch that is core area.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated indices of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_cai(vector_landscape, "class", edge_depth = 0.8)
#' @export

vm_p_cai <- function(landscape, class, edge_depth) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON simple feature.")
  }

  area <- vm_p_area(landscape, class)
  core <- vm_p_core(landscape, class, edge_depth)
  cai <- core$value / area$value * 100

  # return results tibble
  tibble::tibble(
    level = "patch",
    class = as.integer(core$class),
    id = as.integer(1:nrow(core)),
    metric = "cai",
    value = as.double(cai)
  )
}
