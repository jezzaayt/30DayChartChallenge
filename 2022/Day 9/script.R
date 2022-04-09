library(tidyverse)
library(eurolig)

results <- eurolig::gameresults
eurolig::teaminfo

results
unique(results$team_home)
FCBM <- results %>% filter(team_home == "FC Bayern Munich")
FCBM
#ggplot(FCBM, aes(x = points_home, group = season, fill = season)) + geom_density(alpha=.5)# + facet_wrap(~season, scales = "free")

random_teams <- c("FC Barcelona", "CSKA Moscow", "Efes Pilsen", "Real Madrid", "Anadolu Efes Istanbul", "Efes Pilsen Istanbul",
                  ~"Maccabi FOX Tel Aviv", "Maccabi Electra Tel Aviv")

## Rename Efes Pilsen, Efes Pilsen Istanbul and Anadolu Efes Istabul as one due to same team different names
## Renamed Tel Aviv Team names to one grouping. 

df <- results %>% select(season, team_home, points_home)
df_avg <- df %>% group_by(season, team_home) %>% summarise(across(points_home, mean, na.RM=TRUE))
df_avg <- df_avg %>% filter(team_home %in% random_teams)
df_avg[df_avg == "Efes Pilsen"] <- "Anadolu Efes Istanbul"
df_avg[df_avg == "Efes Pilsen Istanbul"] <- "Anadolu Efes Istanbul"
df_avg[df_avg == "Maccabi FOX Tel Aviv"] <- "Maccabi Tel Aviv"
df_avg[df_avg == "Maccabi Electra Tel Aviv"] <- "Maccabi Tel Aviv"

ggplot(df_avg, aes(x = team_home, y = points_home, fill = team_home)) + geom_violin() +
  coord_flip() + theme_minimal()+theme(legend.position = "none", axis.title = element_text(face = "bold")) + labs(title="EuroLeague Average points played at Home",
                                                                        subtitle="Data Source: Eurolig Package | Day 9 #30DayChartChallenge",
                                                                        caption = "Visualisation by:@Jezzaayt",
                                                                        y = "Average Points", x = "Team Name")
       