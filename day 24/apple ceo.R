library(tidyverse)
library(timevis)
# For #30DayChartChallenge day 24 Timeseries Monochrome
# Data from https://www.kaggle.com/ahdvnd/database-for-ceo-dismissal-19922018

# Citing the data:
# Richard J. Gentry, Joseph Harrison, Timothy Quigley, & Steven Boivie. (2021). 
# Open Sourced Database for CEO Dismissal 1992-2018 (Version 2021.02.03) [Data set]. 
# Strategic Management Journal. Zenodo. http://doi.org/10.5281/zenodo.4543893
# This data is from Gentry et al (2021) and can be accessed here: https://onlinelibrary.wiley.com/doi/10.1002/smj.3278?af=R

dfceo <- read_csv("ceo_dismissal_data.csv")

head(dfceo)
dfceo <- dfceo %>% filter(coname == "APPLE INC")

dfceo

df <- dfceo %>% select(coname, year, exec_fullname, leftofc, `Still There` )
df

#though this data does not list all of their CEOs as John Sculley was their third CEO.
# got info about the previous 2 from this site to add to the data frame
# https://www.insideview.com/blog/the-history-of-apple-ceos/
# estimated leave dates but the month and year is more important to my visualisation


# This data seems to be Month Day Year 


df <- rbind(df, c( "APPLE INC", 1981 ,"Michael Scott", "3/1/1981", NA  ))
df <- rbind(df, c("APPLE INC", 1983, "Mike Markkula", "4/1/1983", NA))
#arrange by year so last to latest
df <- df %>% arrange(year)
df$start <- c("2/1/1977", "3/1/1981", "4/1/1983", "6/1/1993", "2/2/1996", "9/1/1997", "8/24/2011" )
# applied the started as a character bad but can then convert

#convert character to date
df$leftofc<- lubridate::mdy(df$leftofc)
df$start <- lubridate::mdy(df$start)
df <- rename(df, end = leftofc)
df <- rename(df, content = exec_fullname)
# renamed the columns to fit for the timevis package but was unable to label in just R, it works better in Shiny/Markdown I found out reading more docs
# If i want a nice simple interactive time line I'd use this if I don't want a title caption etc



timevis(df) 
## Ended up with what I want but alas unable to put a title

df
class(df$`Still There`)
apple_ceo <- ggplot( df, aes(x = start, xend = end , yend = content, y = content, group = 1)) +  geom_point() + geom_segment() +
  labs(title = "Apple CEOs over time",
       subtitle = "This data is from Gentry et al (2021) and can be accessed here:\nhttps://onlinelibrary.wiley.com/doi/10.1002/smj.3278?af=R",
       caption = "By @Jezzaayt | https://github.com/jezzaayt/",
       x = "CEO Start Year",
       y = "CEO") 
# Geom segment receives an error as Tim Cook end date is NA as he is still current CEO

ggsave("appleceos.png", apple_ceo, scale = 1.5)

