#' @title The mean value of all patches Perimeter-Area ratio index at landscape level(vector data)
#' 
#' @description This function allows you to calculate the mean value
#' of all patch ratios in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated mean value is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_perarea_mn(vector_landscape, "class")
#' @export

vm_l_perarea_mn <- function(landscape, class){
  para <- vm_p_perarea(landscape, class)
  para_l <- mean(para$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.integer(NA),
    id = as.integer(NA),
    metric = "para_mn",
    value = as.double(para_l)
  ))
}
