#' @title Total (class) edge(vector data)
#' 
#' @description This function allows you to calculate the total length of edge of whole landscape in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @return  the returned calculated length is in column "value",
#' and this function returns also some important information such as level and metric name,
#' Moreover, class number and the "id" column, although both are "NA" here in the landscape level
#' @examples
#' vm_l_te(vector_landscape)
#' @export

vm_l_te <- function(landscape){
  perim <- vm_p_perim(landscape)
  te <- sum(perim$value)

  # return results tibble
  tibble::new_tibble(list(
    level = "landscape",
    class = as.character(NA),
    id = as.character(NA),
    metric = "te",
    value = as.double(te)
  ))
}
