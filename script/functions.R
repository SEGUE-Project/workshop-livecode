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
District <- "01"#





