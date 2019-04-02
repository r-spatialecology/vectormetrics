#' @title core area(vector data)
#'
#' @description This function allows you to calculate the core area of all patches in square meters
#' Core area is defined as an area that within the patch and its edge is a fixed value from the boundary of the patch.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated core areas of all patches are in column "value",
#' and this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_p_core(vector_landscape, "class", edge_depth = 0.8)
#' @export

# core
vm_p_core <- function(landscape, class, edge_depth) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }

  # extract the multipolygon, cast to single polygons (patch level)

  if(any(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    multi <- landscape[sf::st_geometry_type(landscape)=="MULTIPOLYGON", ]
    landscape_multi<- sf::st_cast(multi, "POLYGON", warn = FALSE)
    landscape_poly <- landscape[sf::st_geometry_type(landscape)=="POLYGON", ]
    landscape <- rbind(landscape_multi, landscape_poly)
  }

  #create the core areas using st_buffer with a negetive distance to the edge of polygons
  core_area <- sf::st_buffer(landscape, dist = -edge_depth) # you can actually buffer negative in sf, with st_buffer(landscape, -edge_depth)

  # calculate the area of each core area
  landscape$core <- sf::st_area(core_area)/10000

  # return results tibble
  class_ids <- dplyr::pull(sf::st_set_geometry(landscape, NULL), class)
  if (class(class_ids) == "factor"){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "core",
    value = as.double(landscape$core)
  )
}
