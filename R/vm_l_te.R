#' @title Total (class) edge(vector data)

#' @description This function allows you to calculate the total length of edge of whole landscape in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated length is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_te(vector_landscape, "class")

#' @export
vm_l_te <- function(landscape, class){
  perim <- vm_p_perim(landscape, class)
  te <- sum(perim$value)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "te",
    value = as.double(te)
  )
}
