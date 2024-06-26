% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vm_c_frac_mn.R
\name{vm_c_frac_mn}
\alias{vm_c_frac_mn}
\title{The mean value of the fractal dimension index of all patches in each class(vector data)}
\usage{
vm_c_frac_mn(landscape, class_col)
}
\arguments{
\item{landscape}{the input landscape image,}

\item{class_col}{the name of the class column of the input landscape}
}
\value{
the returned calculated mean value of each class is in column "value",
and this function returns also some important information such as level, class number and metric name.
Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
}
\description{
This function allows you to calculate the mean value
of fractal dimension index of all patches belonging to class i in a categorical landscape in vector data format
The index is based on the patch perimeter and the patch area and describes the patch complexity
}
\examples{
vm_c_frac_mn(vector_landscape, "class")
}
