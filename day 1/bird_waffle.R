library(tidyverse)
library(waffle)
library(hrbrthemes)
library(ggforce)

# Day 2 - Late doing it
# 30 Day Chart challenge Conmparisons Pictogram

# Data from :https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-06-18

bird_counts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-18/bird_counts.csv")
bird_counts

df2017 <- bird_counts %>% filter(year == "2017") %>% filter(how_many_counted >0)
df <- df2017 %>% filter(year == "2017")
df$total_hours <- NULL
df$how_many_counted_by_hour <- NULL
df$species_latin <- NULL
df$year <- NULL


df %>% count(species, wt = how_many_counted/1000) %>%  ggplot(aes(fill = species, values = n)) +
  geom_waffle(n_rows = 50) + coord_equal() + theme_enhance_waffle() 



# Top 5 birds counted in 2017 

df_5_2017 <- df %>%  slice_max(order_by = how_many_counted, n = 5)
df_5_2017 %>% count(species, wt = how_many_counted/100) %>%  ggplot(aes(fill = species, values = n)) +
  geom_waffle(n_rows = 5) + coord_equal() + 
  theme_ipsum_rc(grid="")+ 
  theme_enhance_waffle()   +
  labs(title="Top 5 birds at Christmas in Hamilton Ontario counted in 2017", 
       subtitle ="1 Square = 100 birds counted\nRounded down", caption = "Jeremy A | https://twitter.com/JezzaAyt | https://github.com/jezzaayt") +
  annotate(geom = "curve", x = 4, y = -3, xend = 2.65, yend = 0.8, curvature = .3, arrow=arrow(length =unit(2, "mm"))) +
  annotate("text", x=4, y=-3.6, label ="Canada Goose (6665)", hjust="left") +
  annotate(geom = "curve", x = 13, y = 7.4, xend = 15, yend = 5, curvature = .3, arrow=arrow(length =unit(2, "mm"))) +
  annotate("text", x=7, y=8.5, label ="European Starling (2844)", hjust="left") +
  annotate(geom = "curve", x = 20.5, y = -3, xend = 24, yend = 0.8, curvature = .3, arrow=arrow(length =unit(2, "mm"))) +
  annotate("text", x=19, y=-3.3, label ="House Sparrow (2731)", hjust="left") +
  annotate(geom = "curve", x = 32, y = 9, xend = 26, yend = 4.5, curvature = .3, arrow=arrow(length =unit(2, "mm"))) +
  annotate("text", x=32.5, y=9, label ="Long-tailed Duck (3465)", hjust="left") +
  annotate(geom = "curve", x = 40, y = -2.6, xend = 36, yend = 1.8, curvature = .3, arrow=arrow(length =unit(2, "mm"))) +
  annotate("text", x=35, y=-3.3, label ="Mallard (5034)", hjust="left") 

df_5_2017


