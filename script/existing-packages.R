
library(sf)
library(tidyverse)

## Data

rotterdam_muni <- st_read("data/rotterdam_500m.gpkg") |>
  st_transform(28992)

## segregation packages

library(OasisR)
library(divseg)
library(segregation)

## dissimilarity index functions

# OasisR
DIDuncan

age_two_count_sf <- rotterdam_muni |>
  mutate(age_under25 = (age_0_15 + age_15_25),
         age_over25 = (age_25_45 + age_45_65 + age_older65)) |>
  select(crs28992res500m, age_under25, age_over25) |>
  drop_na(age_under25, age_over25) |>
  filter()


