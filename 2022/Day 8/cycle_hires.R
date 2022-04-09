library(tidyverse)
library(ggridges)
library(lubridate)
# Day 8 - Mountain Dis
# Data: https://data.london.gov.uk/dataset/number-bicycle-hires

cycle_data <- readxl::read_xlsx("tfl-daily-cycle-hires.xlsx", sheet = "Data")
cycle_data

df_cycle <- cycle_data %>% select(Day, `Number of Bicycle Hires...2`)
df_cycle
names(df_cycle)[2] <- "Number of Bicycle Hires"

df_cycle <- df_cycle %>% filter(Day > as.POSIXct("2021-01-01 00:00:00")) %>% 
                                  filter(Day < as.POSIXct("2022-01-01 00:00:00"))
df_cycle$Month <-(format(df_cycle$Day, "%b"))
levels(df_cycle$`Number of Bicycle Hires`)
months <- df_cycle$Month


ggplot(df_cycle, aes(x = `Number of Bicycle Hires`, y =  Month, fill = stat(x) )) +
  geom_density_ridges_gradient(rel_min_height = 0.01, scale=3) +
  labs(title= "Cycle Hires Per Month in London (2021)", subtitle = "Data Source: Transport For London", fill = "", 
       caption = "Visualisation by: @Jezzayt") +
  theme_ridges() + scale_y_discrete(limits = month.abb)

