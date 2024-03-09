#' @title The Edge density of each class(vector data)
#' 
#' @description This function allows you to calculate the total length of all patches
#' in class i in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class_col the name of the class column of the input landscape
#' @return  the returned calculated total length of perimeter is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_ed(vector_landscape, "class")
#' @export

vm_c_ed <- function(landscape, class_col){
  # prepare class and patch ID columns
  prepare_columns(landscape, class_col, NULL) |> list2env(envir = environment())

  peri <- vm_p_perim(landscape, class_col)
  peri_sum <- stats::aggregate(peri$value, list(peri$class), sum)

  # total area in the landscape
  area <- vm_p_area(landscape, class_col)
  area_sum <- sum(area$value) * 10000

  peri_sum$ED <- peri_sum[, 2] / area_sum * 10000

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(peri_sum)),
    class = as.character(peri_sum[, 1]),
    id = as.character(NA),
    metric = rep("ED", nrow(peri_sum)),
    value = as.double(peri_sum[, 2])
  ))
}
