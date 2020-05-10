require(tidyverse)
require(sf)

#JUST JOIN BY NAMES

#the premise is just to do what is recommended - join and alter any that don't match out of the box. 

colocation <- read_csv('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/plot_colocation_data/output/colocation_country_referenced.csv')

polygon_names <- c(colocation %>% pull(polygon1_name), colocation %>% pull(polygon2_name)) %>% unique()

#uk gadm boundaries
uk <- st_read('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.geojson')

target_names <- uk %>% pull(NAME_2)

setdiff(polygon_names, target_names)
setdiff(target_names, polygon_names)

i <- intersect(polygon_names, target_names)
polygon_names_diff <- setdiff(polygon_names, i)
target_names_diff <- setdiff(target_names, i)

t <- tibble(polygon_name = polygon_names_diff, 
       target_name = c(target_names_diff, rep(NA, 1)))

#get this to work
write_csv(t, '/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/plot_colocation_data/output/name_comparison.csv') 

#replace names
name_rep <- read_csv('output/name_replacement.csv') %>% 
  replace_na(list("fb_name" = "NA")) %>% 
  replace_na(list("replacement" = "NA"))


colocation <- read_csv('output/colocation_country_referenced.csv')

for (i in 1:length(name_rep %>% pull(replacement))){
  colocation <- colocation %>% mutate(polygon1_name = gsub(name_rep$fb_name[i], name_rep$replacement[i], polygon1_name))
  colocation <- colocation %>% mutate(polygon2_name = gsub(name_rep$fb_name[i], name_rep$replacement[i], polygon2_name))
}

#filter the only name that appears in fb and not gadm
colocation <- colocation %>% filter(polygon1_name != 'Aberdeen City')

#remove na values from fb data, (polygon1), names present in GADM, not fb
colocation <- colocation %>% 
  mutate(polygon1_name = ifelse(polygon1_name == 'NA', NA, polygon1_name),
         polygon2_name = ifelse(polygon2_name == 'NA', NA, polygon2_name))

#get mean colocation between and within tile

mean_ts <- colocation %>% 
  mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
  group_by(type, polygon1_name, ds) %>% 
  summarise(mean_colocation = mean(link_value, na.rm=T)) %>% 
  left_join(uk %>% st_set_geometry(NULL), by = c('polygon1_name' = 'NAME_2'))

write_csv(mean_ts, '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/mean_ts.csv')

#top 10 linkages between a county
mean_top_10 <- colocation %>% 
  mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
  filter(type == 'Between') %>% 
  group_by(polygon1_name, polygon2_name) %>% 
  summarise(mean_colocation = mean(link_value, na.rm=T))

poly_names <- mean_top_10 %>% pull(polygon1_name) %>% unique()

top_10_data <- list()
for (i in 1:length(poly_names)){
  
  name <- poly_names[i]
  
  top_10_data[[name]] <- mean_top_10 %>% filter(polygon1_name == name) %>% arrange(-mean_colocation) %>% slice(1:15)
}
mean_top_10 <- do.call(rbind, top_10_data)

write_csv(mean_top_10, '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/top_n_between.csv')





