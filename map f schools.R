library(tmap)
library(tmaptools)
library(sf)
Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk-11.0.2/")
library(OpenStreetMap)

# LILLE

schools1 <- read_sf("./Lille.geojson")
basemap1 <- read_osm(schools1, minNumTiles = 20, type = "stamen-terrain")
png("./Lille.png", width = 3000, height = 3000)
tm_shape(basemap1) +
  tm_rgb() +
  tm_shape(schools1) +
  tm_dots(
    col = "firebrick",
    size = 25,
    alpha = 0.35,
    shape = 21
  ) +
  tm_scale_bar(
    color.dark = "grey20",
    position = c("left", "bottom"),
    size = 5.5
  ) +
  tm_compass(
    size = 25,
    position = c("left", "top"),
    color.dark = "grey20",
    just = "bottom"
  ) +
  tm_layout(
    frame.lwd = 0,
    title.size = 2,
    frame = "white",
    title.position = c("center", "top")
  )
dev.off()

# PARIS

schools2 <- read_sf("./Paris.geojson")
basemap2 <-
  read_osm(schools2, minNumTiles = 30, type = "stamen-terrain")
png("./Paris.png", width = 3000, height = 3000)
tm_shape(basemap2) +
  tm_rgb() +
  tm_shape(schools2) +
  tm_dots(
    col = "firebrick",
    size = 20,
    alpha = 0.3,
    shape = 21
  ) +
  tm_scale_bar(
    color.dark = "grey20",
    position = c("left", "bottom"),
    size = 5
  ) +
  tm_compass(
    size = 25,
    position = c("left", "top"),
    color.dark = "grey20",
    just = "bottom"
  ) +
  tm_layout(
    frame.lwd = 0,
    title.size = 2,
    frame = "white",
    title.position = c("center", "top")
  )
dev.off()

# LYON 

schools3 <- read_sf("./Lyon.geojson")
basemap3 <-
  read_osm(schools3, minNumTiles = 20, type = "stamen-terrain")
png("./Lyon.png", width = 3000, height = 3000)
tm_shape(basemap3) +
  tm_rgb() +
  tm_shape(schools3) +
  tm_dots(
    col = "firebrick",
    size = 25,
    alpha = 0.4,
    shape = 21
  ) +
  tm_scale_bar(
    color.dark = "grey20",
    position = c("left", "bottom"),
    size = 5
  ) +
  tm_compass(
    size = 25,
    position = c("left", "top"),
    color.dark = "grey20",
    just = "bottom"
  ) +
  tm_layout(
    frame.lwd = 0,
    title.size = 2,
    frame = "white",
    title.position = c("center", "top")
  )
dev.off()

# TOULOUSE

schools4 <- read_sf("./Toulouse.geojson")
basemap4 <-
  read_osm(schools4, minNumTiles = 20, type = "stamen-terrain")
png("./Toulouse.png", width = 3000, height = 3000)
tm_shape(basemap4) +
  tm_rgb() +
  tm_shape(schools4) +
  tm_dots(
    col = "firebrick",
    size = 25,
    alpha = 0.35,
    shape = 21
  ) +
  tm_scale_bar(
    color.dark = "grey20",
    position = c("left", "bottom"),
    size = 5
  ) +
  tm_compass(
    size = 25,
    position = c("left", "top"),
    color.dark = "grey20",
    just = "bottom"
  ) +
  tm_layout(
    frame.lwd = 0,
    title.size = 2,
    frame = "white",
    title.position = c("center", "top")
  )
dev.off()

