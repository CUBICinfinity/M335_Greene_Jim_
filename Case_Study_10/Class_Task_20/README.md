 https://r-spatial.github.io/sf/articles/sf2.html
 
 Geospatial Data Abstraction Library
 
 sf includes GDAL?
 reads and writes most everything.
 
 creates directory:
 fname <- system.file("shape/nc.shp", package="sf")
 
 ?st_read # has more settings.
 ?read_sf
 
 st_transform(crs = ####) will code for it.
 
Try this for Idaho sometime in the future
 "+proj=tmerc +lat_0=42 +lon_0=-114 +k=0.9996 +x_0=2500000 +y_0=1200000 +ellps=GRS80 +units=m +no_defs"