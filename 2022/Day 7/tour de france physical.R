library(tidyverse)
library(tdf)
library(janitor)
library(ggforce)
# Day 7 - Physical#
tdf <- tdf::editions
tdf

df <- tdf %>% select(start_date, winner_name, distance, time_overall, stage_wins, age) 
df <- na.omit(df)
duplicate_winners <- df %>% group_by(winner_name)%>% get_dupes(winner_name) %>% tally()

dup_df  <- df %>% filter(winner_name %in% duplicate_winners$winner_name)
dup_df

dup_df$speed = dup_df$distance / dup_df$time_overall
names(dup_df)[2] <- "Winner Names"

ggplot(dup_df, aes(x = start_date, y = speed, color = `Winner Names`))  + geom_point()  +
  theme_minimal() + geom_mark_circle(aes( fill = `Winner Names`, label  = `Winner Names`),con.border = "all") + 
  labs(title = "Average speeds for Tour De France winners", 
       subtitle  ="Lance Armstrong had the longest winner streak though he was on steroids during time of his winnings" ,  
       x = "Year", y = "Average Speed (KM)", 
       caption ="Visualisation @JezzaAyt" ) +
  theme(axis.title = element_text(face = "bold"), axis.text = element_text(size = 14 )) 
