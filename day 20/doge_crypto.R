library(tidyverse)
library(tidyquant)
# Day 20 - Timeseries - Upwards
# Data set
#https://www.kaggle.com/dhruvildave/dogecoin-historical-data 
# Data seems to be updated daily by the uploader 

df <- read_csv("DOGE-USD.CSV")
head(df)
df <- na.omit(df)
names(df) <- tolower(names(df))


df_2021 <- filter(df, date >= "2021-01-01")

doge_all_time <- ggplot(df, aes(x = date, y = close)) +geom_barchart(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "DOGE (Ð) Cryptocurrency ll time ", y = "Close Price ($)", caption = "https://github.com/jezzaayt")

doge_all_time 


doge_2021 <- ggplot(df_2021, aes(x = date, y = close)) +geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "DOGE (Ð) Cryptocurrency in 2021 ", y = "Close Price ($)",  caption = "https://github.com/jezzaayt") 

doge_2021

df_21_april <- filter(df, date >= "2021-04-01") 
df_21_april <- df_21_april %>% mutate( make_date(year, month, day))

df_21_april$date <- day(df_21_april$date)

df_21_april
april21 <- ggplot(df_21_april, aes(x = date, y = close)) +geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "DOGE (Ð) Cryptocurrency in April 2021 ", y = "Close Price ($)", x ="Day",
        subtitle = "Data: https://www.kaggle.com/dhruvildave/dogecoin-historical-data",caption = "https://github.com/jezzaayt") + theme_tq() + 
  scale_x_continuous(breaks = seq(20)) +scale_y_continuous(breaks=seq(0,0.5, by = 0.025))
april21

ggsave(april21, scale = 1.5, units="cm",filename =  "doge_april_2021.png")
