#' @title The Edge density of the whole landscape(vector data)
#' 
#' @description This function allows you to calculate the total length of all patches
#' in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @return  the returned calculated total length of perimeter is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_ed(vector_landscape)
#' @export

vm_l_ed <- function(landscape){
  peri <- vm_p_perim(landscape)
  peri_sum <- sum(peri$value)

  # total area in the landscape
  area <- vm_p_area(landscape)
  area_sum <- sum(area$value) * 10000
  ed <- peri_sum / area_sum

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "ed",
    value = as.double(ed)
  ))
}
