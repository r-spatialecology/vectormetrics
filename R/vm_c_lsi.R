#' @title Landscape shape index (vector data)
#' 
#' @description This function allows you to calculate the ratio between the actual edge length of class i
#' and the hypothetical minimum edge length of class i in a categorical landscape in vector data format.
#' The minimum edge length equals the edge length if class i would be maximally aggregated
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated index are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_lsi(vector_landscape, "class")
#' @export

vm_c_lsi <- function(landscape, class){
  # prepare class and patch ID columns
  prepare_columns(landscape, class, NA) |> list2env(envir = environment())

  peri <- vm_p_perim(landscape, class)
  peri_class <- stats::aggregate(peri$value, by = list(peri$class), sum, na.rm = FALSE)

  area <- vm_p_area(landscape, class)
  area$value <- area$value * 10000
  area_c <- stats::aggregate(area$value, by = list(area$class), sum, na.rm = FALSE)

  area_c$R <- sqrt(area_c[, 2] / pi)
  area_c$mini <- 2 * pi * area_c$R
  lsi <- peri_class[, 2] / area_c$mini

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(area_c)),
    class = as.character(area_c[, 1]),
    id = as.character(NA),
    metric = rep("lsi", nrow(area_c)),
    value = as.double(lsi)
  ))
}
