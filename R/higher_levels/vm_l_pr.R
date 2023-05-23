#' @title Patch richness (vector data)
#'
#' @description This function allows you to calculate the Patch richness
#' in a categorical landscape in vector data format, Patch richness index is a simplest diversity index
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape

#' @return  the returned calculated index is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_pr(vector_landscape, "class")

#' @export

vm_l_pr <- function(landscape, class){
  np <- vm_c_np(landscape, class)
  pr <- length(np$class)
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "pr",
    value = as.double(pr)
  )
}
