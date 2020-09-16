suppressPackageStartupMessages({
  require(tidyverse)
})
#get mean colocation between and within tile

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_gadm_names.csv',
           '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/data/top_n_between_archive.csv')
.args <- commandArgs(trailingOnly = T)

colocation <- read_csv(.args[1])

create_top_n <- function(dates){
  
  date_range <- dates[(length(dates) - 3): length(dates)]
  
  mean_top_10 <- colocation %>% 
    mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between')) %>% 
    filter(type == 'Between') %>% 
    filter(ds %in% date_range) %>% 
    group_by(polygon1_name, polygon2_name) %>% 
    summarise(mean_colocation = mean(link_value, na.rm=T), .groups = 'drop') %>% 
    mutate(release_date = max(dates))
  
  return(mean_top_10)
}

dates <- colocation %>% pull(ds) %>% unique() %>% sort()

archive <- list()

for(i in 1:length(dates)){
  
  if (i < (length(dates) - 3)){
    
    archive[[i]] <- create_top_n(dates[(length(dates) - 3 - i):(length(dates) - i)])
    
  }
  
}

archive <- do.call(rbind, archive)

write_csv(archive, .args[length(.args)])

