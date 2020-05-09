require(sf)
require(tidyverse)
uk <- read_rds('/Users/hamishgibbs/Downloads/gadm36_GBR_2_sf.rds') %>% 
  as_tibble() %>% 
  st_as_sf()

colnames(uk)
uk %>% select(NAME_1, GID_2, NAME_2, TYPE_2)
