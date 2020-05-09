require(sf)
require(tidyverse)

uk <- read_rds('/Users/hamishgibbs/Downloads/gadm36_GBR_2_sf.rds') %>% 
  as_tibble() %>% 
  st_as_sf()

irl <- read_rds("/Users/hamishgibbs/Downloads/gadm36_IRL_0_sf.rds") %>% 
  as_tibble() %>% 
  st_as_sf() %>% 
  select(NAME_0) %>% 
  rename(NAME_1 = NAME_0) %>% 
  mutate(GID_2 = NA, NAME_2 = NA, TYPE_2 = NA)


colnames(uk)
uk <- uk %>% select(NAME_1, GID_2, NAME_2, TYPE_2)

d <- rbind(irl, uk)

st_write(d, '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK.geojson')

ds <- st_read('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.shp')
st_write(d, '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.geojson')
