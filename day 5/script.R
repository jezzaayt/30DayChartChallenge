library(tidyverse)
library(CGPfunctions)

# Data from data.un.org
# UNData for Helath Expenditure csv updated 5th November 2020 



df <- read.csv("SYB63_325_202009_Expenditure on Health.csv")
head(df)

#Making First row as headers
names(df) <- as.matrix(df[1,])

#Deleting the first row to have useable data  and not repeated header names in the first row
df <- df[-1,]
names(df)[names(df) == ""] <- "Countries"

caption <- "Data from UNData - Updated 5th November 2020 - Downloaded 5th April 2021"

df <- df %>% filter(Series == "Current health expenditure (% of GDP)")

# Target Countries for EU
target_countries_eu <- c("Austria", "Germany", "United Kingdom", "Belgium", "Netherlands", "Sweden", "Denmark", "Finland", "Czechia",
                         "Bosnia and Herzegovina", "France", "Lithuania", "Luxembourg", "Portugal", "Norway", "Poland", "Spain", "Slovenia", "Estonia",
                         "Italy", "Hungary", "Ireland", "Bulgaria", "Greece", "Malta", "Latvia","Romania")

df_eu <- df %>% select(Countries, Year, Series, Value) %>% filter(Countries %in% target_countries_eu)
#df_eu$Year <- as.numeric(df_eu$Year)      
df_eu$Value <- as.numeric(df_eu$Value)
newggslopegraph(df_eu,  Year, Value, Countries, Title = "European Countries  Current Health expenditure (% of GDP) ",
                Caption = caption,
                YTextSize = 3,
                LineThickness = 2,
                WiderLabels = TRUE,
                SubTitle = NULL)

target_visited <- c("Austria", "United Kingdom", "Belgium", "Netherlands", "Austria", "South Africa", "Egypt",
                    "Luxembourg", "Italy", "France")

df_visited <- df %>% select(Countries, Year, Series, Value) %>% filter(Countries %in% target_visited)
df_visited$Value <- as.numeric(df_visited$Value)

newggslopegraph(df_visited,  Year, Value, Countries, Title = "Current Health expenditure (% of GDP) ",
                SubTitle = "Countries visited by author of the graph - Jeremy Aytoun",
                Caption = caption,
                YTextSize = 3,
                LineThickness = 2,
                WiderLabels = TRUE)
