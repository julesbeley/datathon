library(raster)
library(sp)
library(geojsonio)
library(ggplot2)
library(mapproj)
library(tidyverse)
library(broom)
URL <-
  "https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/communes.geojson"
communes <- geojson_read(URL, what = "sp")
communes_fortified <- tidy(communes, region = "code")
ggplot() +
  geom_polygon(data = communes_fortified , aes(x = long, y = lat, group = group)) +
  theme_void() +
  coord_map()
donnée2 <- read.csv("./density.csv", header = T, sep = ",")
communes_fortified = communes_fortified %>%
  left_join(. , donnée2, by = c("id" = "COM"))
ggplot() +
  geom_polygon(data = communes_fortified, aes(
    fill = P15_POP,
    x = long,
    y = lat,
    group = group
  )) +
  theme_void() +
  coord_map()
library(viridis)
p <- ggplot() +
  geom_polygon(
    data = communes_fortified,
    aes(
      fill = P15_POP,
      x = long,
      y = lat,
      group = group
    ) ,
    size = 0,
    alpha = 0.9
  ) +
  theme_void() +
  scale_fill_viridis(
    trans = "log",
    breaks = c(1, 5, 10, 20, 50, 100),
    name = "Population density"
  ) +
  theme(
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA),
    panel.background = element_rect(fill = "#f5f5f2", color = NA),
    legend.background = element_rect(fill = "#f5f5f2", color = NA)
  ) +
  coord_fixed(xlim = c(2.7,3.5),
              ylim = c(50.5, 50.75),
              ratio = 1.5)
p
