library(ggridges)
library(tidyverse)

df <- read.csv("penguins.csv")

head(df)

df <- df %>% na.omit()


ggplot(df, aes(x = body_mass_g, y = species, fill = sex)) +
scale_fill_manual(values = alpha(c("red", "blue"), .5))+
  geom_density_ridges(jittered_points = TRUE, scale = 0.95)+
  #geom_density_ridges_gradient(scale = 0.95, ) + 
  facet_wrap(. ~island) +
  labs(title= "Palmer Penguin", subtitle="Density distribution of body of species of penguin / sex on each island.")+
  xlab(label = "Body Mass") + ylab(label = "Species")

ggplot( df, aes (x=species, y=  bill_length_mm, fill=sex)) +
  geom_bar(data = subset(df, sex =="female"), stat="identity")+
  geom_bar(data = subset(df, sex == "male"), stat="identity") + 
  scale_y_continuous(breaks = seq(-0, 300, 500), 
                     labels = paste0(as.character(c(4:0, 1:4)), "mm")) +coord_flip()

                     