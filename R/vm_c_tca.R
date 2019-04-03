#' @title The total core area of each class(vector data)
#' @description This function allows you to calculate the total core area
#' of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated total class core areas are in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_tca(vector_landscape, "class", edge_depth= 1)

#' @export
vm_c_tca <- function(landscape, class, edge_depth){

  core <- vm_p_core(landscape, class, edge_depth)

  core_sum <- stats::aggregate(core$value,
                               by= list(core$class),
                               sum,
                               na.rm = FALSE)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(core_sum[, 1]),
    id = as.integer(NA),
    metric = "tca",
    value = as.double(core_sum[, 2])
  )
}
