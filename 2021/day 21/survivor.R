library(tidyverse)
library(survivoR)
library(ggrepel)
s<- survivoR::viewers %>% filter(season_name ==c("Survivor: Borneo","Survivor: Winners at War"))
# Day 21 - Timeseries - Downwards
tail(survivoR::tribe_colours)

survivoR::season_summary

# Comparing numbers of ratings vs the original season in 2000 and then 2020 season

# Use winner's original tribe color as there seems to be difference's in talk of Koru's Season 40 tribe color Online. 
# Season 1 - Dakal - #D80E0E      
# Season 40 - Tagi - #FF9900

df <- survivoR::viewers
df <- na.omit(df)

df
df_40 <- df %>% filter(season == 40)
df_1 <- df %>% filter(season == 1 )
df_merge <- df_40 %>% full_join(df_1)
df_merge
# I split then merge due to it was if I was a doing filter(season==c(1,40)) it would give me 1 from 40, then 2 from season 1 then 3 from season 40
# unsure if error with filter or I was doing something wrong. 


class(df$season)
# Try and do ratings by season compare first and last season ratings 18-49 year olds (in Million I believe)


survivor_ratings <- ggplot(df_merge, aes(x = episode, y = rating_18_49, color = as.factor(season))) + 
  geom_point(size = 2.5) + scale_color_manual(values = c("#D80E0E", "#FF9900"), name="Season") + geom_line() +
  scale_x_continuous(labels=as.character(df$episode), breaks=df$episode, name = "Episodes") + 
  labs(title = "Survivor season 1 and season 40 ratings", 
       subtitle = "Comparison of the drop of ratings between episodes and seasons.\nFirst season (2000) and latest in (2020)",
       caption = "Data: (survivoR) package\nBy: @JezzaAyt  | https://github.com/jezzaayt ",
       y = "Ratings 18 - 49 Year Olds") +   theme_classic() + geom_label_repel(aes(label = as.factor(rating_18_49)), size = 3.5,
                                                                              alpha = .8)
survivor_ratings
ggsave(survivor_ratings,filename = "survivor.png", scale = 1.5 )

# I know less is more on visualizations but wanted to get a clearer way to know the rating numbers that have dropped

