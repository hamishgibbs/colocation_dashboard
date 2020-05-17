suppressPackageStartupMessages({
  require(tidyverse)
  require(sf)
})

#currently a mess. 
#need to identify misaligned areas
#test that there are no missing areas

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_country_referenced.csv',
           '/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_gadm_names.csv')
.args <- commandArgs(trailingOnly = T)

colocation <- read_csv(.args[1])

uk <- st_read('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/geodata/UK_simple.geojson')

polygon_names <- c(colocation %>% pull(polygon1_name), colocation %>% pull(polygon2_name)) %>% unique()

name_rep <- read_csv('UK/data/name_replacement.csv') %>% 
  replace_na(list("fb_name" = "NA")) %>% 
  replace_na(list("replacement" = "NA")) %>% 
  as_tibble()

for (i in 1:length(name_rep %>% pull(replacement))){
  colocation <- colocation %>% mutate(polygon1_name = gsub(name_rep$fb_name[i], name_rep$replacement[i], polygon1_name))
  colocation <- colocation %>% mutate(polygon2_name = gsub(name_rep$fb_name[i], name_rep$replacement[i], polygon2_name))
}

#filter the only name that appears in fb and not gadm
colocation <- colocation %>% 
  mutate(polygon1_name = ifelse(polygon1_name == "NA", NA, polygon1_name),
         polygon2_name = ifelse(polygon2_name == "NA", NA, polygon2_name)) %>% 
  filter(!is.na(polygon1_name),
         !is.na(polygon2_name))

target_names <- as.character(uk %>% pull(NAME_2))
fb_names <- unique(c(colocation %>% pull(polygon1_name), colocation %>% pull(polygon2_name)))

#there should be one NA country (Ireland)
testthat::expect_equal(length(setdiff(fb_names, target_names)), 0)
testthat::expect_equal(length(setdiff(target_names, fb_names)), 1)

#hard remove areas - data in the Isles of Scilly and the Orkneys is skewed -> 900% increase in colocation in IoS.
#Doesn't appear to have been fixed by new colocation maps. 
colocation <- colocation %>% 
  filter(!polygon1_name %in% c('Isles of Scilly', 'Orkney Islands'))

write_csv(colocation, .args[length(.args)])
