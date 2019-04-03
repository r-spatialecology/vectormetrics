#' CORE (patch level)
#'
#' @description Core area (Core area metric)
#'
#' @param landscape *sf* MULTIPOLYGON or POLYGON feature
#' @param class Name of the class column of the input landscape
#' @param edge_depth Distance (in map units) a location has the be away from the patch edge to be considered as core location
#'
#' @examples
#' vm_p_core(vector_landscape, "class", edge_depth = 0.8)
#'
#' @export

lsm_c_ai <- function(landscape) UseMethod("lsm_c_ai")


vm_p_core <- function(landscape, class, edge_depth) {

  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide PLOYGON or MULTIPLOYGON")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  landscape <- landscape[, c(class, "geometry")]

  # extract the multipolygon, cast to single polygons (patch level)
  landscape <- sf::st_cast(landscape, "POLYGON", warn = FALSE)

  #create the core areas using st_buffer with a negetive distance to the edge of polygons
  core_area <- sf::st_buffer(landscape, dist = -edge_depth)

  # calculate the area of each core area
  landscape$core <- sf::st_area(core_area)/10000

  # get class ids and if factor, coerce to numeric
  class_ids <-  sf::st_set_geometry(landscape, NULL)[, class]
  if (class(class_ids) == "factor"){
    class_ids <- as.numeric(levels(class_ids))[class_ids]
  }

  # return result tibble
  tibble::tibble(
    level = "patch",
    class = as.integer(class_ids),
    id = as.integer(1:nrow(landscape)),
    metric = "core",
    value = as.double(landscape$core)
  )
}
