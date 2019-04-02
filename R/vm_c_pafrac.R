#' @title Perimeter-Area Fractal Dimension(vector data)
#' @description This function allows you to get the result of 2 divided by ß,
#' ß is the slope of the regression of the area against the perimeter in logarithm of each class in a categorical landscape in vector data format
#' @param landscape the input landscape image,
#' @param class the name of the class column of the input landscape
#' @return  the returned calculated slope is in column "value",
#' and this function returns also some important information such as level, class number and metric name.
#' Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
#' at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
#' @examples
#' ## if the class name of input landscape is landcover,
#' ## then write landcover in a double quotation marks as the second parameter.
#' vm_c_pafrac(vector_landscape, "class")

#' @export
vm_c_pafrac <- function(landscape, class){

  area <- vm_p_area(landscape, class)
  perim <- vm_p_perim(landscape, class)
  area$value <- log(area$value * 10000)
  perim$value <- log(perim$value)
  area <- as.data.frame(area)
  perim <- as.data.frame(perim)
  data <- merge(area[ ,c("class", "value", "id")], perim[ ,c("class", "value", "id")], by = "id")
  names(data) <- c("id", "class_area", "area", "class_peri", "perim" )

  n_p <- vm_c_np(landscape, class)
  stor <- c()
  for(i in 1:nrow(n_p)){

    if (n_p$value[n_p$id == i] < 10) {
      stor[i] = NA
    }
    # the class name at each row,
    f <- n_p$class[n_p$id == i]

    model <- lm(data$area[data$class_area == f ] ~ data$perim[data$class_peri == f ])
    summ <- summary(model)
    if (summ$r.squared > 0.8){
      stor[i] = model$coefficients[2]
    } else { stor[i] = NA}
  }

  pafrac <- 2 / stor
  # return results tibble
  tibble::tibble(
    level = "class",
    class = as.integer(n_p$class),
    id = as.integer(NA),
    metric = "pafrac",
    value = as.double(pafrac)
  )
}
