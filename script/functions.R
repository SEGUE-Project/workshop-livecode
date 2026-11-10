# prep

# install packages if needed
# "pak", "ineAtlas", "seg"

# install seg package
# pak::pak("syunhong/seg")

# install ineAtlas
# pak::pak("pablogguz/ineAtlas")


# load packages

library(sf)
library(tidyverse)
library(ineAtlas)
library(seg)

# Fixing issues!
# small patch for the seg package

seg_fixed <- new.env(parent = asNamespace("seg"))

seg_fixed$CRS <- sf::st_crs

for (name in c("spseg", "localenv")) {
  fun <- get(name, envir = asNamespace("seg"))
  environment(fun) <- seg_fixed
  seg_fixed[[name]] <- fun
}

# fixing issue n.2: useC = FALSE

?spseg

# Let's start!!!

options(scipen = 999)
City <- "08019"   # INE munic. code: Barcelona
District <- "01"  # district of Ciutat Vella
Year <- 2022      # year of income atlas


scales <- c(250, 500) # two scales, in meters


# Load data

income <- get_atlas("distribution_sex", "tract")
population <- get_atlas("demographics", "tract")

unique(income$sex)
head(income$sex)

income <- income %>%
  filter(mun_code == City,
         year == Year,
         sex == "total")

population <- population %>%
  filter(mun_code == City,
         year == Year) %>%
  select(tract_code, population)

head(population)

# join income and population by census tract

data <- left_join(income, population,
                  by = "tract_code")

head(data)

# Calculate cumulative income share

shares <- data %>%
  transmute(
    tract_code, population,
    below_5000 = equivinc_below_5000/100,
    below_7500 = equivinc_below_7500/100,
    below_10000 = equivinc_below_10000/100,
    below_40_median = equivinc_below_40p_median/100,
    below_50_median = equivinc_below_50p_median/100,
    below_60_median = equivinc_below_60p_median/100,
    below_140_median = 1 - equivinc_above_140p_median / 100,
    below_160_median = 1 - equivinc_above_160p_median / 100,
    below
    
  )
  
