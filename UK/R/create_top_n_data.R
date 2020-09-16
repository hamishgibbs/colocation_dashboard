suppressPackageStartupMessages({
  require(tidyverse)
})
#get mean colocation between and within tile

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_gadm_names.csv',
           '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/top_n_between.csv')
.args <- commandArgs(trailingOnly = T)

colocation <- read_csv(.args[1])

dates <- colocation %>% pull(ds) %>% unique() %>% sort()

date_range <- dates[(length(dates) - 3): length(dates)]

mean_top_10 <- colocation %>% 
  mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
  filter(type == 'Between') %>% 
  filter(ds %in% date_range) %>% 
  group_by(polygon1_name, polygon2_name) %>% 
  summarise(mean_colocation = mean(link_value, na.rm=T), .groups = 'drop') %>% 
  mutate(release_date = max(dates))

poly_names <- mean_top_10 %>% pull(polygon1_name) %>% unique()

top_10_data <- list()
for (i in 1:length(poly_names)){
  
  name <- poly_names[i]
  
  top_10_data[[name]] <- mean_top_10 %>% filter(polygon1_name == name) %>% arrange(-mean_colocation) %>% slice(1:10)

}

mean_top_10 <- do.call(rbind, top_10_data)

write_csv(mean_top_10, .args[length(.args)])


