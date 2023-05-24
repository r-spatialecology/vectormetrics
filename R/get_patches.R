get_patches <- function(landscape, class, direction = 8) UseMethod("get_patches")

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
      a <- dplyr::filter(landscape_cast, class == class_i)

      nb <- sf::st_relate(a, a, pattern = nb_string, sparse = FALSE)
      nb[lower.tri(nb)] <- NA

      landscape_nb <- purrr::map(seq_len(ncol(nb)), .f = function(patch_i, class_i) {
        nb_ind <- which(nb[, patch_i] == TRUE)
        nb_union <- sf::st_union(a[c(nb_ind, patch_i), ])
        nb_union <- sf::st_sf(geometry = nb_union)
        nb_union$class <- class_i
        nb_union$patch <- patch_i
        nb_union
      }, class_i)

      # for(class_i in seq_len(ncol(nb))) {
      #
      #   nb_ind <- which(nb[, class_i] == TRUE)
      #   if(length(nb_ind) != 0) landscape_nb[nb_ind] <- NULL
      #
      # }
      landscape_nb
    })
    landscape_nb = purrr::flatten(landscape_nb)

    result <- do.call(rbind, landscape_nb)
    result <- sf::st_collection_extract(result, "POLYGON")
    return(result)
  }
}

# r4 = get_patches(vector_landscape, class, direction = 4)
# r8 = get_patches(vector_landscape, class)
#
# r4$patch = as.factor(r4$patch)
# r8$patch = as.factor(r8$patch)
#
# plot(r4[2])
# plot(r8[2])
