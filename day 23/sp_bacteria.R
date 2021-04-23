library(tidyverse)
library(plotly)
# Day 23 Timeseries Tiles
# Data - https://www.kaggle.com/amandalk/sp-beaches-water-quality
# Beaches Water Quality in São Paulo, Brazil



df <- read_csv("sp_beaches.csv")


df_bert <- df %>% filter(City == "BERTIOGA" )

df_cara<- df %>% filter(City == "CARAGUATATUBA") 

# I did not remove NA for this data as I was using a geom_tile
# I wanted to show when there was missing data else it may have looked perhaps a bit odd
# with the else of the data


bert <- ggplot(df_bert, aes(Date, Beach, fill = Enterococcus)) +
  geom_tile() + labs(title = "2012 - 2020 Beach Quality in Bertioga beaches", 
                     subtitle = "Measuring the amount of Enterococcus (CFU/ 100ml)",
                     caption = "Data: https://www.kaggle.com/jboysen/sf-beaches-water\nBy: @JezzaAyt | https://github.com/jezzaayt ")

cara <- ggplot(df_cara, aes(Date, Beach, fill = Enterococcus)) + 
  geom_tile()  + labs(title = "2012 - 2020 Beach Quality in Caraguatatuba beaches", 
                      subtitle = "Measuring the amount of Enterococcus (CFU/ 100ml)",
                      caption = "Data: https://www.kaggle.com/jboysen/sf-beaches-water\nBy: @JezzaAyt | https://github.com/jezzaayt ")




plot_ly(df_bert, x = ~Date, y = ~Beach, z = ~Enterococcus , type = "heatmap") %>%
  layout(title =  list(text = paste("2012 - 2020 Beach Quality in Caraguatatuba beaches",
                                    '<br>',
                                    '<sup>',
                                    'Measuring the amount of Enterococcus (CFU/ 100ml)\n',
                                    '</sup>')),
         xaxis = list(title = "Date <br> Data: https://www.kaggle.com/jboysen/sf-beaches-water\nBy: @JezzaAyt | https://github.com/jezzaayt"),
         autosize = F, margin = list(l=0, r= 0, b=0, t= 50, pad = 0))




plot_ly(df_cara, x = ~Date, y = ~Beach, z = ~Enterococcus , type = "heatmap") %>%
  layout(title =  list(text = paste("2012 - 2020 Beach Quality in Caraguatatuba beaches",
                                    '<br>',
                                    '<sup>',
                                    'Measuring the amount of Enterococcus (CFU/ 100ml)\n',
                                    '</sup>')),
         xaxis = list(title = "Date <br> Data: https://www.kaggle.com/jboysen/sf-beaches-water\nBy: @JezzaAyt | https://github.com/jezzaayt"),
         autosize = F, margin = list(l=0, r= 0, b=0, t= 50, pad = 0))


