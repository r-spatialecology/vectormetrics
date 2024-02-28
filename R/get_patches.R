#' @title Get patches from polygon landscape
#'
#' @description Convert multipolygons to seperate polygons based on chosen neighbourhood type.
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param direction 4 or 8
#' @return sf object with exploded polygons
#' @examples
#' get_patches(vector_landscape, "class", direction = 4)
#' @export
#' @aliases get_patches
#' @rdname get_patches
get_patches <- function(landscape, class, direction = 4){
  UseMethod("get_patches")
}

#' @name get_patches
#' @export
get_patches.sf <- function(landscape, class, direction = 4){

  # cast multipolygons to polygons
  landscape_cast <- landscape |>
    sf::st_cast("POLYGON", warn = FALSE)

  if (direction == 4) {
    # merge by nieghbourhood type based on touching edges
    result <- landscape_cast
    class(result) <- class(result)[!class(result) %in% c("grouped_df", "tbl_df", "tbl")]
    result <- result |> dplyr::select(dplyr::all_of(class))

  } else if (direction == 8){
    # merge by nieghbourhood type based on touching vertices
    nb_string <- "F***T****"
    lsc_classes <- unique(dplyr::pull(landscape, !!class))

    landscape_nb <- purrr::map(lsc_classes, function(class_i) {
      # create neighbourhood matrix for each class
      class_patches <- dplyr::filter(landscape_cast, class == class_i)
      nb <- sf::st_relate(class_patches, class_patches, pattern = nb_string, sparse = FALSE)
      done_shapes = c()

      landscape_nb <- purrr::map(seq_len(ncol(nb)), .f = function(patch_i, class_i) {
        if (!(patch_i %in% done_shapes)){
          # find neighbours of each patch
          nb_ind <- which(nb[, patch_i] == TRUE)
          nb_ind <- c(nb_ind, patch_i)
          indexes <- nb_ind
          indexes <- c(indexes, which(nb[, nb_ind] == TRUE) %% nrow(nb))

          while (length(indexes) && !all(indexes %in% nb_ind)) {
            nb_ind <- unique(c(nb_ind, indexes))
            idx_iter <- indexes
            for (index in idx_iter){
              idx <- which(nb[, index] == TRUE)
              if (!all(idx %in% indexes)){
                indexes <- unique(c(indexes, idx))
              }
            }
          }
          if (length(indexes) > 0){
            nb[indexes,] <<- FALSE
            nb[,indexes] <<- FALSE
          }
          done_shapes <<- c(done_shapes, indexes)

          # merge chosen neighbours
          nb_union <- sf::st_union(class_patches[indexes, ])
          nb_union <- sf::st_sf(geometry = nb_union)
          nb_union$class <- class_i
          nb_union$patch <- patch_i
          nb_union
        }
      }, class_i)

      landscape_nb
    })
    landscape_nb <- purrr::flatten(landscape_nb)

    result <- do.call(rbind, landscape_nb)
    result <- sf::st_collection_extract(result, "POLYGON")

  }
  result$patch <- seq_len(nrow(result))
  rownames(result) <- NULL
  result <- result |> dplyr::select(dplyr::all_of(class), "patch")

  message("Number of patches before conversion: ", nrow(landscape))
  message("Number of patches after conversion: ", nrow(result))
  return(result)
}
