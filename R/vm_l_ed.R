#' @title The Edge density of the whole landscape(vector data)

#' @description This function allows you to calculate the total length of all patches
#' in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated total length of perimeter is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_l_ed(vector_landscape, "class")

#' @export

vm_l_ed <- function(landscape, class){
  peri <- vm_p_perim(landscape, class)
  peri_sum <- sum(peri$value)

  # total area in the landscape
  area <- vm_p_area(landscape, class)
  area_sum <- sum(area$value)* 10000

  ed <- peri_sum/area_sum * 10000
  # return results tibble
  tibble::tibble(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "ed",
    value = as.double(ed)
  )
}
