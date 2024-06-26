% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_patches.R
\name{get_patches}
\alias{get_patches}
\alias{get_patches.sf}
\title{Get patches from polygon landscape}
\usage{
get_patches(landscape, class_col, direction = 4)

\method{get_patches}{sf}(landscape, class_col, direction = 4)
}
\arguments{
\item{landscape}{the input landscape image,}

\item{class_col}{the name of the class column of the input landscape}

\item{direction}{4 or 8}
}
\value{
sf object with exploded polygons
}
\description{
Convert multipolygons to separate polygons based on chosen neighbourhood type.
}
\examples{
get_patches(vector_landscape, "class", direction = 4)
}
