#' @title Perimeter of equal-area circle(vector data)
#'
#' @description Calculate perimeter of equal-area circle
#' @details perimeter of equal-area circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_eac_perim(vector_patches, "class", "patch")
#' @export

vm_p_eac_perim <- function(landscape, class = NA, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class, patch_id) |> list2env(envir = environment())
  landscape <- landscape[, c(class, patch_id)]

  # area of polygons
  landscape$area <- vm_p_area(landscape, class, patch_id)$value * 10000
  circle_perims <- sqrt(landscape$area / pi) * 2 * pi

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class, drop = TRUE]),
    id = as.character(landscape[, patch_id, drop = TRUE]),
    metric = rep("circle_perim", nrow(landscape)),
    value = as.double(circle_perims)
  ))
}
