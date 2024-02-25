#' @title Total (class) edge  (vector data)
#' 
#' @description This function allows you to calculate the total length of edge of class i in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated length is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' vm_c_te(vector_landscape, "class")
#' @export

vm_c_te <- function(landscape, class){
  perim <- vm_p_perim(landscape, class)
  perim_c <- stats::aggregate(perim$value, by = list(perim$class), sum, na.rm = FALSE)

  # return results tibble
  tibble::new_tibble(list(
    level = rep("class", nrow(perim_c)),
    class = as.integer(perim_c[, 1]),
    id = as.integer(NA),
    metric = rep("te", nrow(perim_c)),
    value = as.double(perim_c[, 2])
  ))
}
