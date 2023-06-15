# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(vectormetrics)

square = list(cbind(c(0,1,1,0,0), c(0,0,1,1,0))) |> sf::st_polygon() |>
  sf::st_sfc() |> sf::st_sf(crs = "EPSG:2180")
square$class = 1

test_check("vectormetrics")
