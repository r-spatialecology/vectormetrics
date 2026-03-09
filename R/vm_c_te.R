#' @title Total (class) edge  (vector data)
#' 
#' @description This function allows you to calculate the total length of edge of class i in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @param count_boundary Include landscape boundary in edge length (default: TRUE)
#' @return  the returned calculated length is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @details
#' Total edge for a class includes all edges between that class and other classes.
#' Internal edges between patches of the same class are not counted (they disappear when patches are merged).
#' This is calculated as the perimeter of the union of all patches of that class.
#' 
#' Note: The default differs from landscapemetrics (default: FALSE) because vector
#' polygon boundaries are explicit geometric features. Set count_boundary=FALSE for
#' direct comparison with landscapemetrics results.
#' @examples
#' vm_c_te(vector_landscape, "class")
#' vm_c_te(vector_landscape, "class", count_boundary = FALSE)
#' @export

vm_c_te <- function(landscape, class_col, count_boundary = TRUE){
  # Prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  # Get landscape boundary once if needed
  landscape_boundary <- if (!count_boundary) {
    sf::st_union(landscape) |> 
      sf::st_cast("MULTILINESTRING")
  } else {
    NULL
  }
  
  # Calculate edge length for each class
  classes <- unique(landscape[[class_col]])
  
  te_values <- vapply(classes, function(cls) {
    # Union all patches of this class
    class_union <- landscape[landscape[[class_col]] == cls, ] |>
      sf::st_union() |>
      sf::st_cast("MULTILINESTRING")
    
    # Calculate total boundary length
    total_length <- sf::st_length(class_union) |> as.numeric()
    
    # Subtract landscape boundary portion if requested
    if (!count_boundary) {
      boundary_overlap <- sf::st_intersection(class_union, landscape_boundary)
      overlap_length <- if (length(boundary_overlap) > 0) {
        sf::st_length(boundary_overlap) |> as.numeric()
      } else {
        0
      }
      total_length - overlap_length
    } else {
      total_length
    }
  }, numeric(1))

  # Return results tibble
  tibble::new_tibble(list(
    level = rep("class", length(classes)),
    class = as.character(classes),
    id = rep(NA_character_, length(classes)),
    metric = rep("te", length(classes)),
    value = as.double(te_values)
  ))
}
