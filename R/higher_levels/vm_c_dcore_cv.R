#' @title The coefficient of variation of number of disjunct core areas in each class (vector data)
#' @description This function allows you to calculate the coefficient of variation
#' of each class  belonging to one class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @param edge_depth the fixed distance to the edge of the patch
#' @return  the returned calculated coefficient of variation in each class is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_dcore_cv(vector_landscape, "class", edge_depth= 1)

#' @export
vm_c_dcore_cv <- function(landscape, class, edge_depth){

  dcore <- vm_p_ncore(landscape, class, edge_depth)

  dcore_cv <- stats::aggregate(dcore$value,
                               by= list(dcore$class),
                               vm_cv)

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(dcore_cv[, 1]),
    id = as.integer(NA),
    metric = "dcore_cv",
    value = as.double(dcore_cv[, 2])
  )
}
