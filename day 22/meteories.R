library(tidyverse)
library(gganimate)

# Day 22 Timeseries Animation
# Data using TidyTuesday's Meteorite Impacts originally from  NASA 
# Data TidyTuesday 2019-06-11

meteorites <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-11/meteorites.csv")

met <- meteorites %>% select(name, year, lat, long, mass, fall) %>% arrange(year)
met <- na.omit(met)

#met$year <- as.numeric(met$year)
met <- met %>% filter(year >=1900 & year < 2100)
# under 2100 as there is an outlier in the dataset
met
max(met$year)

#convert from grams to kg 
met$mass  <- as.numeric(as.character(met$mass)) / 1000

met
met_gif <- ggplot(met, aes(x = year, y=  mass, size = mass, color = fall)) + geom_point() +
  transition_time(as.integer(year)) +  
  labs(title="Meteorites found from 1900 to 2013", subtitle =  "Year: {frame_time}", y = "Mass (KG)", x = "Year",
       caption = "Data: TidyTuesday 2019-06-11 Meteorite Impacts\nBy: @JezzaAyt | https://github.com/jezzaayt ") + 
  shadow_wake(wake_length = 0.2) + scale_y_continuous(limits = c(0,60000), breaks = seq(0, 60000, by = 5000) ) 

animate(met_gif, duration = 10)


anim_save("meteorites.gif", last_animation())
