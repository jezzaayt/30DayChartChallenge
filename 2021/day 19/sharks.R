library(tidyverse)

sharks <- read_csv("attacks.csv")
head(sharks)
rownames(sharks)[rownames(sharks) =="UNITED ARAB EMIRATES (UAE)"] <- "UNITED ARAB EMIRATES"


# For Day 19 of 30 Day Chart Challenge
# Time Series - Global Change

# Looking at shark attacks per year

# Global Shark Data from Kaggle
# https://www.kaggle.com/teajay/global-shark-attacks

#Cleaning for use

df <- sharks %>% select(Year,Country,  Sex)
df <- na.omit(df)
df <- filter(df, Year != 0) #
df <- filter(df, Year >= 2008)
df<- df %>% add_count(Year,Country, Sex, name = "Attacks_per_gender_per_year")
df$Country[df$Country =="UNITED ARAB EMIRATES (UAE)"] <- "UNITED ARAB EMIRATES"
#Due to a duplicate in the csv but having (UAE) had to rename the few rows
#unique(df$Country)
tail(df)
df <- df %>% add_count(Year,Country, name="Per_Year")
#df <- 
unique(df)
top_counts(df$Country, max_char = 5, max_levels = 5)
sharks_plot <- ggplot(df, aes( x = Year, y = Attacks_per_gender_per_year, fill = Sex)) + geom_bar(position="dodge", stat="identity")  + 
  theme_minimal() + 
  labs(title = "Shark Attacks between Females and Males over years across the globe between 2008 - 2018", y = "Number of Attacks Per Year") +
   scale_y_continuous(breaks=seq(0,65, by = 5))  + scale_x_continuous(labels=as.character(df$Year), breaks=df$Year)
facet_shark <- sharks_plot +facet_grid(~Sex)
sharks_plot
ggsave(facet_shark, width =25, units = "cm", filename = "shark_attacks_m_f.png")

ggsave(sharks_plot, width =25, units = "cm", filename = "shark_attacks.png")

shark_attacked_countries <- c("USA", "AUSTRALIA", "SOUTH AFRICA", "BRAZIL", "BAHAMAS")

top_df <- df %>% filter(Country %in% shark_attacked_countries)
top_df$Country
top_sharks_plot <- ggplot(top_df, aes( x = Year, y = Per_Year, fill = Country)) + geom_bar(position="dodge", stat="identity")  + 
  theme_minimal() + 
  labs(title = "Shark Attacks between Females and Males over years across the globe between 2008 - 2018", y = "Number of Attacks Per Year") +
  scale_y_continuous(breaks=seq(0,80, by = 5))  + scale_x_continuous(labels=as.character(df$Year), breaks=df$Year)
top_sharks_plot <- top_sharks_plot + geom_line(top_df, mapping = aes(x = Year, y = Attacks_per_gender_per_year, color = Sex), stat="unique", linetype=1, size = 1)+
  scale_color_manual(values=c("#FEE715FF", "#101820FF"))+
  facet_wrap(~Country)
top_sharks_plot
max(top_df$Per_Year)

ggsave(top_sharks_plot, width =35, height = 25, units = "cm", filename = "shark_attacks_top5_countries.png")

