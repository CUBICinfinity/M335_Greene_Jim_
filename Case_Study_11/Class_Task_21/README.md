http://rstudio.github.io/leaflet/

install.packages("leaflet")

library(leaflet)

m <- leaflet() %>% # blank map (there is nothing to see)
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map

leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18))

---------

WORKS WITH Base R, sp, and maps

http://rstudio.github.io/leaflet/map_widget.html
teaches about polygons and formulas

---------

setView(lng = -71.0589, lat = 42.3601, zoom = 12)

addProviderTiles(providers$Stamen.Toner)
addProviderTiles(providers$CartoDB.Positron)
addProviderTiles(providers$Esri.NatGeoWorldMap)


#WMS Tiles

leaflet() %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )
  
see http://rstudio.github.io/leaflet/basemaps.html for more on layers

---------

Custom Icons:

greenLeafIcon <- makeIcon(
  iconUrl = "http://leafletjs.com/examples/custom-icons/leaf-green.png",
  iconWidth = 38, iconHeight = 95,
  iconAnchorX = 22, iconAnchorY = 94,
  shadowUrl = "http://leafletjs.com/examples/custom-icons/leaf-shadow.png",
  shadowWidth = 50, shadowHeight = 64,
  shadowAnchorX = 4, shadowAnchorY = 62
)

leaflet(data = quakes[1:4,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, icon = greenLeafIcon)
  
# Make a list of icons. We'll index into it based on name.
oceanIcons <- iconList(
  ship = makeIcon("ferry-18.png", "ferry-18@2x.png", 18, 18),
  pirate = makeIcon("danger-24.png", "danger-24@2x.png", 24, 24)
)
-----------
# Some fake data
df <- sp::SpatialPointsDataFrame(
  cbind(
    (runif(20) - .5) * 10 - 90.620130,  # lng
    (runif(20) - .5) * 3.8 + 25.638077  # lat
  ),
  data.frame(type = factor(
    ifelse(runif(20) > 0.75, "pirate", "ship"),
    c("ship", "pirate")
  ))
)

leaflet(df) %>% addTiles() %>%
  # Select from oceanIcons based on df$type
  addMarkers(icon = ~oceanIcons[type])
  
many more marker options: http://rstudio.github.io/leaflet/markers.html

----------

also, see http://rstudio.github.io/leaflet/colors.html

