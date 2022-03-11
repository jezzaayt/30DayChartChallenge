library(datasets)
library(tidyverse)
library(reshape2)

# Day 7 - Distributions Physical 
 # Chick weight

df<- datasets::ChickWeight
head(df)
#df <- df %>% filter(Chick %in% c(1,2))


# all chicks
ggplot(df, aes(x = Chick,  fill=Diet, y = weight)) +  geom_boxplot(position = "dodge") +
  scale_y_continuous(limits = c(0,400), breaks = seq(0,400,25))+
  labs(caption = "Data from Datasets Chick weight", title="Chick weight distribution by Diet. ")



ggplot(df, aes(x = reorder(Chick, -weight), fill = Diet, y= weight)) + geom_boxplot()+
scale_y_continuous(limits = c(0,400), breaks = seq(0,400,25))+
  labs(caption = "Data from Datasets Chick weight", title="Chick weight distribution by Diet. ", subtitle =  "Ordered by Heaviest to lightest",
       x = "Chicks")
