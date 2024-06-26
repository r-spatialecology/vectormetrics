% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vm_c_lsi.R
\name{vm_c_lsi}
\alias{vm_c_lsi}
\title{Landscape shape index (vector data)}
\usage{
vm_c_lsi(landscape, class_col)
}
\arguments{
\item{landscape}{the input landscape image,}

\item{class_col}{the name of the class column of the input landscape}
}
\value{
the returned calculated index are in column "value",
and this function returns also some important information such as level, class number and metric name.
Moreover, the "id" column, although it is just NA here at class level. we need it because the output struture of metrics
at class level should correspond to patch level one by one, and then it is more convinient to combine metric values at different levels and compare them.
}
\description{
This function allows you to calculate the ratio between the actual edge length of class i
and the hypothetical minimum edge length of class i in a categorical landscape in vector data format.
The minimum edge length equals the edge length if class i would be maximally aggregated
}
\examples{
vm_c_lsi(vector_landscape, "class")
}
