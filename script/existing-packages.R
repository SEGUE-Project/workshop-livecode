
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
         )

