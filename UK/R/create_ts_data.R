suppressPackageStartupMessages({
  require(tidyverse)
  require(sf)
})
#get mean colocation between and within tile

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_gadm_names.csv',
           '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/mean_ts.csv')
.args <- commandArgs(trailingOnly = T)

colocation <- read_csv(.args[1]) %>% 
  mutate(connection_type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
  filter(connection_type == 'Between')

uk <- st_read('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.geojson') %>% 
  mutate(NAME_2 = as.character(NAME_2))

mean_ts <- colocation %>% 
  group_by(connection_type, polygon1_name, ds) %>% 
  summarise(mean_colocation = mean(link_value, na.rm=T)) %>% 
  left_join(uk %>% st_set_geometry(NULL), by = c('polygon1_name' = 'NAME_2')) %>% 
  mutate(type = 'abs_value')

early_date <- colocation %>% gutils::col_unique(ds) %>% min()

early_ref <- colocation %>% 
  filter(ds == early_date) %>% 
  group_by(connection_type, polygon1_name) %>% 
  summarise(early_colocation = mean(link_value, na.rm=T))

perc_ts <- mean_ts %>% 
  left_join(early_ref, by = c('polygon1_name', 'connection_type')) %>% 
  mutate(mean_colocation = ((mean_colocation)/early_colocation) * 100) %>% 
  mutate(type = 'perc_change') %>% 
  select(-early_colocation)

d <- rbind(mean_ts, perc_ts)

write_csv(d, .args[length(.args)])
