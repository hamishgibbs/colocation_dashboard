suppressPackageStartupMessages({
  require(tidyverse)
  require(cowplot)
  require(colorspace)
})

source('../covid_facebook_mobility/utils/plot_default_theme.R')

.args <- c('/Users/hamishgibbs/Documents/Covid-19/covid_facebook_mobility/data/colocation_output/colocation_country_referenced.csv',
           '/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/images/colocation_plot.pdf')

.args <- commandArgs(trailingOnly = T)

col <- read_csv(.args[1])

plot_data <- col %>% mutate(type = ifelse(polygon1_id == polygon2_id, 'Within', 'Between'),
                            type_date = paste0(country_1, type, ds),
                            country_type = paste0(country_1, ' ', type),
                            country_date = paste0(country_1, ' ', ds))
plot_data_wi <- plot_data %>% filter(type == 'Within')

plot_data_bw <- plot_data %>% filter(type == 'Between')

plot_custom_theme <- theme(strip.background = element_rect(fill = 'transparent'))

date_labels <- as.character(format(plot_data_wi$ds %>% unique(),"%b-%d"))
date_breaks <-as.numeric(plot_data_wi$ds %>% unique())


p_bw <- plot_data_bw %>% 
  ggplot() +
  geom_density(aes(x = log(link_value), group = ds, colour = as.numeric(ds)), size = 0.5) +
  facet_wrap(~country_1, ncol = 2) +
  scale_colour_continuous_sequential(palette = 'Teal', breaks = date_breaks, labels=date_labels) +
  labs(colour = '') +
  ggtitle('Outside home area') +
  xlab('Mean colocation probability (log)') +
  ylab('Density') +
  theme_bw() +
  plot_default_theme +
  plot_custom_theme +
  theme(legend.position = 'right',
        text = element_text(size = 12))

gutils::ggsave_pdf_png(p_bw, .args[length(.args)], 8, 6)
print('Success.')

