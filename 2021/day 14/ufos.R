library(tidyverse)
library(lubridate)
library(ggforce)
library(scales)
 # 30 day Chart Challenge
# Day 14 - Space

# Again unfortunately, don't have time to do it daily so I try and do when I can and if i can on topic


ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")
ufos <- ufo_sightings[!is.na(ufo_sightings$country),]
head(ufos)

#convert to only year
ufos$date_time <- mdy_hm(ufos$date_time)
ufos$date_time <- as_date(ufos$date_time)
ufos$date_time <- lubridate::year(ufos$date_time)
head(ufos$date_time)

colnames(ufos)[1] <- "Year"
options(scipen = 0)
ufos
ufos_df <- ufos %>% select(Year, country, encounter_length) 
ufos_df <-  ufos_df[,order(colnames(ufos_df$Year))]
ufos_df
ufos

ufo_avg<- ufos %>% group_by(Year,country) %>% dplyr::summarize(encounter_length = mean(encounter_length , na.rm=TRUE))

  
ufos_bind <- ufos %>% select(Year, country) %>% left_join(select(ufo_avg,encounter_length))
ufos_bind

df <- ufos_bind %>% count(Year, country, encounter_length)
colnames(df)[4] <- "Encounters per year"
df

# Count number of encounters per year/country
# Year 
# Country
df %>% filter(Year == 2014)

ufo_plot <- ggplot(df, aes(x = Year, y = `Encounters per year`, color = country, size = encounter_length)) + geom_point(alpha = 0.5) +
  scale_size(guide="none") 

ufo_plot + labs(title = "UFOs over time period", subtitle = "Bubbleplot showing reports of UFO encounters more often over time.",
                caption = "https://github.com/jezzaayt") +geom_smooth()

zoom_roswell_year <- ufo_plot + facet_zoom(xlim =c(1943, 1945), ylim = c(2,5))
zoom_roswell_year + labs(title = "Famous UFO Crash Year", subtitle = "Zoomed in using ggforce showing 3 in total sightings for US this year",
                         caption = "https://github.com/jezzaayt") 
