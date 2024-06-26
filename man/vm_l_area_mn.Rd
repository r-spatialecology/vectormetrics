% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vm_l_area_mn.R
\name{vm_l_area_mn}
\alias{vm_l_area_mn}
\title{The mean value of all patch areas at landscape level(vector data)}
\usage{
vm_l_area_mn(landscape)
}
\arguments{
\item{landscape}{the input landscape image,}
}
\value{
the returned calculated mean value of areas is in column "value",
and this function returns also some important information such as level and metric name,
}
\description{
This function allows you to calculate the mean value
of all patch areas in a categorical landscape in vector data format
}
\examples{
vm_l_area_mn(vector_landscape)
}
