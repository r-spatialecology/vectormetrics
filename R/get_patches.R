get_patches <- function(landscape, class, direction = 8){
  UseMethod("get_patches")
}

get_patches.sf <- function(landscape, class, direction = 8){

  landscape_cast <- landscape |>
    sf::st_cast("POLYGON", warn = FALSE)

  if (direction == 4) {
    result <- landscape_cast |>
      dplyr::group_by_at(class) |>
      dplyr::mutate(patch = seq_len(dplyr::n()))
    result$patch = as.factor(result$patch)
    class(result) = class(result)[!class(result) %in% c("grouped_df", "tbl_df", "tbl")]
    result = result |> dplyr::select(class, patch, geometry)
    return(result)

  } else if (direction == 8){
    nb_string <- "F***T****"
    lsc_classes <- unique(dplyr::pull(landscape, !!class))

    landscape_nb <- purrr::map(lsc_classes, function(class_i) {
      class_patches <- dplyr::filter(landscape_cast, class == class_i)
      nb <- sf::st_relate(class_patches, class_patches, pattern = nb_string, sparse = FALSE)
      done_shapes = c()

      landscape_nb <- purrr::map(seq_len(ncol(nb)), .f = function(patch_i, class_i) {
        if (!(patch_i %in% done_shapes)){
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

          nb_union <- sf::st_union(class_patches[indexes, ])
          nb_union <- sf::st_sf(geometry = nb_union)
          nb_union$class <- class_i
          nb_union$patch <- patch_i
          nb_union
        }
      }, class_i)

      landscape_nb
    })
    landscape_nb = purrr::flatten(landscape_nb)

    result <- do.call(rbind, landscape_nb)
    result <- sf::st_collection_extract(result, "POLYGON")
    return(result)
  }
}
