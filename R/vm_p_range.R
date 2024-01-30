#' @title Range Index(vector data)
#'
#' @description Calculate Range Index
#' @details ratio between diameter of equal-area circle and diameter of smallest circumscribing circle
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param patch_id the name of the id column of the input landscape
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_range(vector_landscape, "class")
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_range <- function(landscape, class, patch_id = NA) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    stop("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    message("MULTIPOLYGON geometry provided. You may want to cast it to seperate polygons with 'get_patches()'.")
  }

  # select geometry column for spatial operations and the column that identifies the classes
  if (is.na(patch_id)){
    patch_id <- "id"
    landscape[, patch_id] <- seq_len(nrow(landscape))
  }
  landscape[, class] <- as.factor(landscape[, class, drop = TRUE])
  landscape <- landscape[, c(class, patch_id)]

  # calculate the diameter of equal-area circle
  landscape$circle_diam <- vm_p_eac_perim(landscape, class)$value / pi

  # calculate the diameter of smallest circumscribing circle
  landscape$circum_diam <- vm_p_circum(landscape, class)$value

  # ratio of perimeter of equal-area circle and its convex hull
  range_index <- landscape$circle_diam / landscape$circum_diam

  # return results tibble
  class_ids <- sf::st_set_geometry(landscape, NULL)[, class, drop = TRUE]
  if (methods::is(class_ids, "factor")){
    class_ids <- as.numeric(as.factor(levels(class_ids)))[class_ids]
  }

  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.integer(class_ids),
    id = as.integer(seq_len(nrow(landscape))),
    #class = landscape[, class, drop = TRUE],
    #id = landscape[, patch_id, drop = TRUE],
    metric = rep("range_index", nrow(landscape)),
    value = as.double(range_index)
  ))
}
