library(tidyverse)
library(WorldFlora)
library(MetBrewer)
WFO.download()
df <- WFO.data %>% select(family,genus)
na.omit(df$genus)
df <- df[!(df$genus ==""),]
dataframe <- df %>% count(family, genus)

dataframe <- dataframe %>% filter(family =="Rosaceae" & n > 50)
ggplot(dataframe, aes(x=reorder(genus, n), y = n, fill = n)) + geom_col() + coord_flip()+
  geom_text(aes(label = n), position=position_stack(vjust=.5))+
  scale_fill_gradientn(colors=met.brewer("Derain",5))+labs(title="Count of Genus within Rosaceae over 50",
                                                           caption= "Source:WorldFlora library", x = "Genus Names", y = "Count", fill = "Count")+
  theme_minimal() + annotate("text", y = 7500, x="Geum", label = "Visualisation: Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt")
