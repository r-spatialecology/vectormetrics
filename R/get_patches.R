



get_patches <- function(landscape) UseMethod("get_patches")

get_patches.sf <- function(landscape, class, direction = 8){

  lsc_classes <- landscape %>%
    pull(!!class) %>%
    unique()

  if (direction == 4) nb_string =  "F***1****"
  if (direction == 8) nb_string =  "F***T****"

  landscape_cast <- sf::st_cast(landscape, "POLYGON", warn = FALSE)

  landscape_nb <- map(lsc_classes, function(class_i) {
    a <- landscape_cast %>%
      filter(class == class_i)

    nb <- st_relate(a, a, pattern = nb_string, sparse = FALSE)
    nb[lower.tri(nb)] <- NA

    landscape_nb <- map(seq_len(ncol(nb)), function(patch_i) {

      nb_ind <- which(nb[, patch_i] == TRUE)
      nb_union <- st_union(a[c(nb_ind, patch_i), ])
      nb_union <- st_sf(geometry = nb_union)
      nb_union$class <- patch_i
      nb_union
    })

    for(class_i in seq_len(ncol(nb))) {

      nb_ind <- which(nb[, class_i] == TRUE)
      if(length(nb_ind) != 0) landscape_nb[nb_ind] <- NULL

    }

    landscape_nb
  }) %>%
    flatten()

  result <- do.call(rbind, landscape_nb)
  result
}

