
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

# create variables and matrix
age_two_count_sf <- rotterdam_muni |>
  mutate(age_under25 = (age_0_15 + age_15_25),
         age_over25 = (age_25_45 + age_45_65 + age_older65)) |>
  select(crs28992res500m, age_under25, age_over25) |>
  drop_na(age_under25, age_over25) |>
  filter(age_under25 + age_over25 > 0)

age_two_count <- age_two_count_sf |>
  st_drop_geometry()

age_two_count_matrix <- age_two_count |>
  select(age_under25, age_over25) |>
  as.matrix()

# compute dissimilarity index
dissim_OasisR <- DIDuncan(age_two_count_matrix)
dissim_OasisR



# divseg
ds_dissim

dissim_divseg <- ds_dissim(
  age_two_count,
  c(age_under25, age_over25)
)

dissim_divseg_value <- dissim_divseg[[1]]
dissim_divseg_value


# segregation

dissimilarity

# transforming data into long format

age_two_count_long <- age_two_count |>
  select(crs28992res500m, age_under25, age_over25) |>
  pivot_longer(!crs28992res500m, names_to = "group", values_to = "n") |>
  filter(n > 0)

dissim_segregation <- dissimilarity(
  age_two_count_long,
  group = "group",
  unit = "crs28992res500m",
  weight = "n"
)

dissim_segregation

dissim_segregation_value <- dissim_segregation$est[[1]]
dissim_segregation_value
