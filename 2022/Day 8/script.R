library(tidyverse)
library(ggthemes)
#Day 8 - Mountains
# Data Source - http://www.hills-database.co.uk/downloads.html

data <- read.csv("DoBIH_v17_3.csv")
df <- data %>% select(Name, Metres, Latitude, Longitude   )
df
ggplot( df, aes(x = Longitude, y = Latitude, color = Metres)) + geom_point() +theme_map() +
  scale_color_gradient2_tableau("Red-Green-White Diverging", breaks = seq(0,1400,200)) + 
  labs(title="Map of British and Irish Mountains/Hills", subtitle = "Source: Hills-Database", 
       caption = "Visuslisation: @Jezzaayt") +theme(panel.background = element_rect(fill = "gray60"),
                                                    legend.background = element_rect(fill = "gray60"))
