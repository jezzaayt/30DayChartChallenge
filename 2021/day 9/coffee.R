library(tidyverse)
library(viridis)
library(hrbrthemes)
#Data from TidyTuesdays
#Originally from Coffee Quality DB

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2020/2020-07-07
df <- read.csv("coffee_ratings.csv")
head(df)
df<- na.omit(df)

#Using data which has more than one entry 
#This then makes the Robusta species of coffee not shown and only looking at Arabica 

df$species
#Filter more than 5 country of origins so any time a country has 5 or more country ratings. 
coffee <- df %>% group_by(country_of_origin) %>% filter(n()>5)
#Filter any variety which has more than 1
coffee_variety <- coffee %>% group_by(variety) %>% filter(n()>1)  

  
ggplot(coffee, aes(x= country_of_origin, y = total_cup_points, fill = country_of_origin) )+
  geom_violin(show.legend = F) +coord_flip() + scale_fill_viridis(discrete=TRUE) + theme_ipsum_pub() + 
  scale_color_viridis(discrete=T) + 
  labs(title = "Coffee ratings by country",
       caption = "Jezza A | https://github.com/jezzaayt")+
  xlab(label = "Country of Origin") + ylab(label = "Total Cup Points") +
  scale_y_continuous( limits=c(76,88), breaks = seq(76,88, by = 2), minor_breaks = seq(76,88, by = 1))


ggplot(coffee_variety, aes(x= variety, y = total_cup_points, fill = variety) )+
  geom_violin(show.legend = F) +coord_flip() + scale_fill_viridis(discrete=TRUE) + theme_ipsum_pub() + 
  scale_color_viridis(discrete=T) + 
  labs(title = "Coffee ratings by variety",
       caption = "Jezza A | https://github.com/jezzaayt")+
  xlab(label = "Variety") + ylab(label = "Total Cup Points")

# Due to na.omit it omits a large number of the coffee 