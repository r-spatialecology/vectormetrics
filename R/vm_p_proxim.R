#' @title Proximity Index(vector data)
#'
#' @description Calculate Proximity Index
#' @details ratio between average distance from all points of equal-area circle to its center and average distance from all points of shape to its center
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param patch_col the name of the id column of the input landscape
#' @param n number of grid points to generate
#' @param progress TRUE/FALSE, whether to show progress bar
#' @return the function returns tibble with the calculated values in column "value",
#' this function returns also some important information such as level, class, patch id and metric name.
#' @examples
#' vm_p_proxim(vector_landscape, class_col = "class", n = 1000)
#' @references
#' Angel, S., Parent, J., & Civco, D. L. (2010). Ten compactness properties of circles: Measuring shape in geography: Ten compactness properties of circles.
#' The Canadian Geographer / Le Géographe Canadien, 54(4), 441–461. https://doi.org/10.1111/j.1541-0064.2009.00304.x
#' @export

vm_p_proxim <- function(landscape, class_col = NULL, patch_col = NULL, n = 1000, progress = TRUE) {
  # check whether the input is a MULTIPOLYGON or a POLYGON
  if(!all(sf::st_geometry_type(landscape) %in% c("MULTIPOLYGON", "POLYGON"))){
    rlang::abort("Please provide POLYGON or MULTIPOLYGON")
  } else if (all(sf::st_geometry_type(landscape) == "MULTIPOLYGON")){
    rlang::inform("MULTIPOLYGON geometry provided. You may want to cast it to separate polygons with 'get_patches()'.", .frequency = "once", .frequency_id = "1")
  }

  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, patch_col) |> list2env(envir = environment())
  landscape <- landscape[, c(class_col, patch_col)]

  if (progress){
    prog_valid <- 1
    progress_bar <- utils::txtProgressBar(min = 0, max = nrow(landscape), style = 3, char = "=")
  } else{
    prog_valid <- NA
    progress_bar <- utils::txtProgressBar(initial = NA)
  }

  for (i in seq_len(nrow(landscape))){
    shape <- landscape[i, ]
    igp <- get_igp(shape, n)
    cent <- geos::geos_centroid(shape)

    igp_dist <- geos::geos_distance(igp, cent)
    landscape$igp_dist[i] <- mean(igp_dist)
    utils::setTxtProgressBar(progress_bar, value = i * prog_valid)
  }
  close(progress_bar)

  radiuses <- vm_p_eac_perim(landscape, class_col, patch_col)$value / (2 * pi) * 0.66
  proximity <- radiuses / landscape$igp_dist

  # return results tibble
  tibble::new_tibble(list(
    level = rep("patch", nrow(landscape)),
    class = as.character(landscape[, class_col, drop = TRUE]),
    id = as.character(landscape[, patch_col, drop = TRUE]),
    metric = rep("proxim_idx", nrow(landscape)),
    value = as.double(proximity)
  ))
}
