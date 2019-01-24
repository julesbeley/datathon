library(tidyverse)
library(ggplot2)
library(tidyverse)
library(geojsonio)
library(broom)
library(viridis)

communes <-
  geojson_read("communes.geojson",
               what = "sp")

communes_fortified <- tidy(communes, region = "code")

ggplot() +
  geom_polygon(data = communes_fortified , aes(x = long, y = lat, group = group)) +
  theme_void() +
  coord_map()

donnée2 <- read.csv("density_pop3.csv", header = T, sep = ",")

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

Ecoles <- read.csv("Ecoles.csv", header = T, sep = ";")

Ecoles %>%
  group_by(Code.commune) %>%
  summarise(nbEcoles = n()) -> Ecoles

communes_fortified = communes_fortified %>%
  left_join(. , Ecoles, by = c("id" = "Code.commune"))

communes_fortified %>%
  filter(!is.na(nbEcoles)) -> communes_fortified

communes_fortified %>%
  mutate(P15_POP = P15_POP / nbEcoles) -> communes_fortified

p <- ggplot() +
  geom_polygon(
    data = communes_fortified,
    aes(
      fill = communes_fortified$P15_POP,
      x = long,
      y = lat,
      group = group
    ) ,
    size = 0,
    alpha = 0.9
  ) +
  theme_void() +
  scale_fill_viridis(
    name ="Inhabitants School",
    option = "inferno", direction = -1,
    guide = guide_legend(
      name = "Number of inhabitants",
      keyheight = unit(3, units = "mm"),
      keywidth = unit(8, units = "mm"),
      label.position = "bottom",
      nrow = 1
    )
  ) +
  theme(
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA),
    panel.background = element_rect(fill = "#f5f5f2", color = NA),
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    plot.caption = element_text(
      size = 12,
      color = "#4e4d47",
      margin = margin(b = 0.3, r = -99, unit = "cm")
    ),
    legend.position = c(0.7, 0.09)
  ) + coord_map()
p