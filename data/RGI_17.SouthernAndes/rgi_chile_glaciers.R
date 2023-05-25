#chilean glaciers in RGI6 
library(maptools)
library(maps)
library(raster)
library(spdep)
library(ggmap)
library(ggsn)
library(ggspatial)
library(rgdal)
library(sf)
library(ggplot2)
library(dplyr)

# Load shape file
glaciers<-st_read("/Users/milliespencer/Desktop/nsidc0770_17.rgi60.SouthernAndes/17_rgi60_SouthernAndes.shp")
#if want to use simplifed outlines for speedy computation: 
simplifed_glaciers<-st_read("/Users/milliespencer/Desktop/nsidc0770_17.rgi60.SouthernAndes/simplified_chilean_glacier_outlines.shp")
summary(glaciers)
head(glaciers)

#change from WGS coordinate system to meters:  
#basins_reproj <- st_transform(basins, st_crs(5361))
#very simplified basin outlines to speed up computations 
ggplot() + geom_sf(data=glaciers)
#load catchment attributes 
glacier_attributes<-read.csv("/Users/milliespencer/Desktop/nsidc0770_17.rgi60.SouthernAndes/17_rgi60_SouthernAndes_hypso.csv", header = TRUE)
head(glacier_attributes)
point_area<-glacier_attributes$Area
#weird so many 0s... maybe just stick with shapefile... 
merged_data <- left_join(glacier_attributes, glaciers, by = "RGIId")

area<-glaciers$Area
aspect<-glaciers$Aspect
zmax<-glaciers$Zmax
zmin<-glaciers$Zmin
zmed<-glaciers$Zmed
slope<-glaciers$Slope
longitude<-glaciers$CenLon
latitude<-glaciers$CentLat


#mean slope: 
ggplot() + 
  geom_sf(data = glaciers) + 
  geom_point(data = merged_data, aes(x = CenLon, y = CentLat, color = Area)) 
#arg need to figure out coordinates ... 


