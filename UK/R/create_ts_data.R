suppressPackageStartupMessages({
  require(tidyverse)
  require(sf)
})
#get mean colocation between and within tile

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_gadm_names.csv',
           '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/mean_ts.csv')
.args <- commandArgs(trailingOnly = T)

colocation <- read_csv(.args[1])

uk <- st_read('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.geojson')

mean_ts <- colocation %>% 
  mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
  group_by(type, polygon1_name, ds) %>% 
  summarise(mean_colocation = mean(link_value, na.rm=T)) %>% 
  left_join(uk %>% st_set_geometry(NULL), by = c('polygon1_name' = 'NAME_2'))

write_csv(mean_ts, .args[length(.args)])
