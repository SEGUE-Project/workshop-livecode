
library(sf)
library(tidyverse)

rotterdam_muni <- st_read("data/rotterdam_muni.gpkg") |>
  st_transform(28992)