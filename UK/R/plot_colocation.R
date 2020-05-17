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


p_wi <- plot_data_wi %>% 
  ggplot() +
  geom_density(aes(x = log(link_value), group = ds, colour = as.numeric(ds)), size = 0.5) +
  facet_wrap(~country_1, ncol = 2) +
  scale_colour_continuous_sequential(palette = 'Teal', breaks = date_breaks, labels=date_labels) +
  xlab('Probability of a 5 minute colocation (log)') +
  ggtitle('Within home area') +
  theme_bw() +
  plot_default_theme +
  plot_custom_theme +
  theme(text = element_text(size = 12))

p_bw <- plot_data_bw %>% 
  ggplot() +
  geom_density(aes(x = log(link_value), group = ds, colour = as.numeric(ds)), size = 0.5) +
  facet_wrap(~country_1, ncol = 2) +
  scale_colour_continuous_sequential(palette = 'Teal', breaks = date_breaks, labels=date_labels) +
  labs(colour = '') +
  ggtitle('Outside home area') +
  theme_bw() +
  plot_default_theme +
  plot_custom_theme +
  theme(axis.title.x = element_blank(),
        text = element_text(size = 12))

legend <- get_legend(
  # create some space to the left of the legend
  p_bw + theme(legend.box.margin = margin(0, 0, 0, 12))
)

plots <- plot_grid(p_bw + theme(legend.position = 'none'), p_wi + theme(legend.position = 'none'), nrow=2)
p <- plot_grid(plots, legend, rel_widths = c(0.85, 0.15))

gutils::ggsave_pdf_png(p, .args[length(.args)], 8, 7)
print('Success.')

