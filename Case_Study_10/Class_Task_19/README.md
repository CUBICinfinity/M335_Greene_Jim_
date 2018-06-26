citation("USAboundaries")

Lincoln A. Mullen and Jordan Bratt, "USAboundaries: Historical
and Contemporary Boundaries of the United States of America,"
Journal of Open Source Software 3, no. 23 (2018): 314,
https://doi.org/10.21105/joss.00314.


library(USAboundaries) 
library(sf) # for plotting and projection methods
#> Linking to GEOS 3.6.2, GDAL 2.2.4, proj.4 5.0.0

states_1840 <- us_states("1840-03-12")
plot(st_geometry(states_1840))
title("U.S. state boundaries on March 3, 1840")

# you will run into a lot of package dependencies. just install them.

devtools::install_github("tidyverse/ggplot2")
# needed to use sf with ggplot2; may need to restart r first to do properly

st_as_sf() # converting from other libraries

#this will work

nc <- read_sf(system.file("shape/nc.shp", package = "sf"), 
  quiet = TRUE,  
  stringsAsFactors = FALSE
)

library(maps)

nz_map <- map("nz", plot = FALSE)
nz_sf <- st_as_sf(nz_map)

----------

To get the datum and other coordinate system metadata, use st_crs()

st_crs(cities)
