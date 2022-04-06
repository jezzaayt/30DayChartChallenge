library(tidyverse)
library(ggforce)
# Day 6 - Our World in Data
# Data source: https://ourworldindata.org/illicit-drug-use
# citing for reference 


drug_overdoses <-read.csv("deaths-drug-overdoses.csv")
names(drug_overdoses)[4] <- "Opiod_Deaths"
names(drug_overdoses)[5] <- "Cocaine_Deaths"
names(drug_overdoses)[6] <- "Other_Drugs"
names(drug_overdoses)[7] <- "Amphetamines"

#Had to subset into their own df as it wasnt workign with a c("")
uk <- drug_overdoses %>% filter(Entity == "United Kingdom")
usa <- drug_overdoses %>% filter(Entity == "United States")
de <-  drug_overdoses %>% filter(Entity == "Germany")
za <- drug_overdoses %>% filter(Entity == "South Africa")
se <- drug_overdoses %>% filter(Entity=="Sweden")
at <- drug_overdoses %>% filter(Entity == "Austria")
df <- rbind(uk, usa, de, za, se, at)

df 

ggplot(df, aes(x = Year, y = `Opiod_Deaths`, color = Entity, size = `Opiod_Deaths`)) + geom_point() +
  facet_zoom(y = `Opiod_Deaths` <= 2000)+
  #facet_zoom(y = Entity == "Austria") + 
  theme_bw() + labs(title= "Opiod Deaths", subtitle = "Source: OurWorldInData", 
                    caption = "Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt")

ggplot(df, aes(x = Year, y = `Opiod_Deaths`, color = Entity, size = `Opiod_Deaths`)) + geom_point() +
  theme_bw() + labs(title= "Opiod Deaths", subtitle = "Source: OurWorldInData", 
                    caption = "Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt")+
  scale_y_continuous(breaks = c(0,10000,20000,30000,40000,45000, 50000,55000 ))

