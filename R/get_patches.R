get_patches <- function(landscape) UseMethod("get_patches")

get_patches.sf <- function(landscape, class, direction = 8){

  lsc_classes <- unique(dplyr::pull(landscape, !!class))

  if (direction == 4) nb_string =  "F***1****"
  if (direction == 8) nb_string =  "F***T****"

  landscape_cast <- sf::st_cast(landscape, "POLYGON", warn = FALSE)

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
  result
}

