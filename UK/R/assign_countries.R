#for now - group by country 
suppressPackageStartupMessages({
  require(tidyverse)
})

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/Facebook_Data/Britain_Colocation',
           '/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_country_referenced.csv')

.args <- commandArgs(trailingOnly = T)

colocation <- list.files(.args[1], full.names = T)

colocation <- lapply(colocation, read_csv, col_types = cols())

colocation <- do.call(rbind, colocation)

#select records with //
col <- colocation %>% 
  mutate(country_1 = sapply(strsplit(name_stack_1, " // "), "[", 1),
         country_2 = sapply(strsplit(name_stack_2, " // "), "[", 1))

scottish_locations <- c('City of Edinburgh', 'Argyll and Bute', 'Fife', 
                        'East Lothian', 'Eilean Siar', 'Orkney Islands')
welsh_locations <- c('Cardiff', 'Conwy', 'Swansea')
english_locations <- c('Poole', 'Essex', 'Suffolk', "Lancashire", 
                       "Wirral", "Cornwall", "Hampshire", 
                       "City of Kingston-upon-Hull", "Northumberland" ,"Halton", 
                       "Southend-on-Sea", "Kent", "Blackpool", "Brighton and Hove", 
                       "Torbay", "East Riding of Yorkshire", "Isle of Wight", 'East Sussex', 
                       'North Lincolnshire', 'Isles of Scilly', 'North Lincolnshire', 'Medway')
NI_locations <- c('Antrim and Newtownabbey', 'Mid and East Antrim')
IoM_locations <- c('Marown', 'Laxey', 'Andreas', 'German', 'Michael', 'Santon')
other_locations <- c('Faroe Islands')

testthat::test_that('No admin areas are missing a country', {
  testthat::expect_identical(setdiff(col %>% filter(is.na(country_2)) %>% pull(polygon2_name) %>% unique(), c(scottish_locations, welsh_locations, english_locations, NI_locations, IoM_locations, other_locations)), character(0))
})

#there is a nicer way to do this
col <- col %>% 
  mutate(country_1 = ifelse(polygon1_name %in% scottish_locations, 'Scotland', country_1),
               country_1 = ifelse(polygon1_name %in% welsh_locations, 'Wales', country_1),
               country_1 = ifelse(polygon1_name %in% english_locations, 'England', country_1),
               country_1 = ifelse(polygon1_name %in% NI_locations, 'Northern Ireland', country_1),
               country_1 = ifelse(polygon1_name %in% IoM_locations, 'Isle of Man', country_1),
               country_1 = ifelse(polygon1_name %in% other_locations, 'Other', country_1),
               country_2 = ifelse(polygon2_name %in% scottish_locations, 'Scotland', country_2),
               country_2 = ifelse(polygon2_name %in% welsh_locations, 'Wales', country_2),
               country_2 = ifelse(polygon2_name %in% english_locations, 'England', country_2),
               country_2 = ifelse(polygon2_name %in% NI_locations, 'Northern Ireland', country_2),
               country_2 = ifelse(polygon2_name %in% IoM_locations, 'Isle of Man', country_2),
               country_2 = ifelse(polygon2_name %in% other_locations, 'Other', country_2))

col <- col %>% filter(country_1 %in% c('Scotland', 'England', 'Wales', 'Northern Ireland') & country_2 %in% c('Scotland', 'England', 'Wales', 'Northern Ireland'))

write_csv(col, .args[length(.args)])

