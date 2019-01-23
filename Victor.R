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
    name = "Population density",
    guide = guide_legend(
      keyheight = unit(3, units = "mm"),
      keywidth = unit(12, units = "mm"),
      label.position = "right",
      title.position = 'top',
      nrow = 1
    )
  ) +
  theme(
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA),
    panel.background = element_rect(fill = "#f5f5f2", color = NA),
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    
    plot.title = element_text(
      size = 22,
      hjust = 0.01,
      color = "#4e4d47",
      margin = margin(
        b = -0.1,
        t = 0.4,
        l = 2,
        unit = "cm"
      )
    ),
    plot.subtitle = element_text(
      size = 17,
      hjust = 0.01,
      color = "#4e4d47",
      margin = margin(
        b = -0.1,
        t = 0.43,
        l = 2,
        unit = "cm"
      )
    ),
    plot.caption = element_text(
      size = 12,
      color = "#4e4d47",
      margin = margin(b = 0.3, r = -99, unit = "cm")
    ),
    
    legend.position = c(0.7, 0.09)
  ) +
  coord_map()
p
