library(tidyverse)
  library(ggpubr)
library(ggrepel)
# Using my watched movies and shows which I begun to track since Pandemic and went further back on some cases
# Small snippet of my data I collect for this. 

df <- read.csv("movies and shows.csv")
names(df)[names(df)=="ï..Year"] <- "Year"

df[df == 0]<-NA

df <- df %>% pivot_longer(cols = c(Netflix, Amazon.Prime, Disney., Other), names_to = "Platform", values_to = "Count")
df[df=="Amazon.Prime"] ="Amazon Prime"
df[df=="Disney."] ="Disney"

ggplot(df, aes(x = Year, y = Count, fill = Platform)) + geom_col() + 
  labs(title="Movies and series watched Per Platform") + theme_classic2() + 
  geom_label_repel(aes(label = Count), position = position_stack(vjust=.5), show.legend =F)+
  scale_x_continuous(breaks = c(2014, 2015, 2017,2018, 2019, 2020, 2021, 2022))+ 
  annotate("text", x = 2021, y = 75, label = "Ended Netflix\nin 2021" )+
  annotate("text", x = 2020, y = 690, label = "Watching\nDisney+ in 2020") +
  annotate("text", x = 2020, y = 400, label = "Pandemic hit in 2020", angle = 54)+
  annotate("text", x = 2015, y = 550, label = "Day 1 - 30 Day Chart Challenge\nPart-to-Whole\nMy Own Data")+
  annotate("text", 2015, 400, label = "Visualisation:@Jezzaayt")+
  annotate("text", 2015, 380, label = "https://github.com/jezzaayt")+
  scale_fill_manual(values = c("Amazon Prime"= "#7BA640","Netflix" = "#D81F26", 
                                "Disney" = "#01ffff", "Other"="#5B5EA6" ))
  
df$Platform
