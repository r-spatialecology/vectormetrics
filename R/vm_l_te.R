#' @title Total (landscape) edge (vector data)
#' 
#' @description Calculate the total length of all edges in a categorical landscape in vector data format
#' @param landscape the input landscape image
#' @param count_boundary Include landscape boundary in edge length (default: TRUE)
#' @return A tibble with the calculated edge length in the "value" column,
#' along with level and metric name metadata
#' @details
#' Total edge is calculated as the sum of all unique edge segments in the landscape.
#' Shared edges between patches are counted only once (not double-counted).
#' By default (count_boundary=TRUE), the outer landscape boundary is included.
#' If count_boundary=FALSE, only internal edges between patches are included.
#' 
#' Note: The default differs from landscapemetrics (default: FALSE) because vector
#' polygon boundaries are explicit geometric features, while raster landscapes have
#' implicit grid boundaries. Set count_boundary=FALSE for direct comparison with
#' landscapemetrics results.
#' 
#' The calculation uses: internal_edges = (sum_all_perimeters - outer_boundary) / 2
#' @examples
#' vm_l_te(vector_landscape)
#' vm_l_te(vector_landscape, count_boundary = FALSE)
#' @export

vm_l_te <- function(landscape, count_boundary = TRUE){
  # Calculate outer boundary of entire landscape
  outer_boundary <- sf::st_union(landscape) |>
    sf::st_cast("MULTILINESTRING") |>
    sf::st_length() |>
    as.numeric()
  
  # Calculate internal edges from patch perimeters
  # Formula: sum(all perimeters) = outer + 2*internal
  # Therefore: internal = (sum - outer) / 2
  perim_sum <- sum(vm_p_perim(landscape)$value)
  internal_edges <- (perim_sum - outer_boundary) / 2
  
  # Total edge based on count_boundary parameter
  te <- if (count_boundary) {
    internal_edges + outer_boundary
  } else {
    internal_edges
  }

  # Return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = NA_character_,
    id = NA_character_,
    metric = "te",
    value = as.double(te)
  ))
}
