#' @title Form factor/Compactness(vector data)
#'
#' @description Calculate form factor or compactness
#' @details sqrt(4 * area / pi) / perimeter
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_comp(vector_patches, "class", "patch")
#' @references
#' Jiao, L., Liu, Y., & Li, H. (2012). Characterizing land-use classes in remote sensing imagery by shape metrics.
#' ISPRS Journal of Photogrammetry and Remote Sensing, 72, 46–55. https://doi.org/10.1016/j.isprsjprs.2012.05.012
#' @export

vm_p_comp <- function(landscape, class = NA, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  # calculate the area of polygons
  landscape$area <- vm_p_area(landscape, class, patch_id)$value * 10000

  # calculate the perimeter of polygons
  landscape$perim <- vm_p_perim(landscape, class, patch_id)$value

  # ratio of perimeter of convex hull and polygon perimeters
  comp_index <- (4 * pi * landscape$area) / landscape$perim ^ 2

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("comp_index", nrow(landscape)),
    value = as.double(comp_index)
  ))
}
