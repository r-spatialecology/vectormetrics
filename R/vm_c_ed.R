#' @title The Edge density of each class(vector data)

#' @description This function allows you to calculate the total length of all patches
#' in class i in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated total length of perimeter is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_ed(landscape, "landcover")

#' @export

vm_c_ed <- function(landscape, class){
  peri <- vm_p_perim(landscape, class)
  peri_sum <- stats::aggregate(peri$value, list(peri$class), sum)
  names(peri_sum) <- c("class", "perimeter")
  # total area in the landscape
  area <- vm_p_area(landscape, class)
  area_sum <- sum(area$value)* 10000

  peri_sum$ED <- peri_sum$perimeter/area_sum * 10000

  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(peri_sum$class),
    id = as.integer(NA),
    metric = "ED",
    value = as.double(peri_sum$ED)
  )
}
