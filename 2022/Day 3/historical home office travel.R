library(tidyverse)
# Data source: https://data.gov.uk/dataset/cb05f060-c889-4466-ac82-8b99c8730e0b/home-office-flight-data
# Data under use of Open Government License: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/


df <- read.csv("Home_Office_Air_Travel_Data_2011.csv", header=TRUE)
df

df <- df %>% count(Departure_2011, Ticket_class_description, Supplier_name)
ggplot(df, aes(x = Departure_2011, y = `Supplier_name`, size = n,
               color = `Ticket_class_description`)) + geom_point()+
  annotate("text",x="November", y="IBERIA", 
           label = "Flybe British European in November\nat 560 flights in November 2011") +
  annotate("text", x = "November", y ="CARIBBEAN AIRLINES", 
           label ="British Airways most Business tickets\nat 65 November 2011" ) +
  labs(title = "UK Home Office Flights in 2011", size="Count", color = "Ticket Class",
       x = "Depature Month", y = "Airline") +ggpubr::theme_pubr()+
  annotate("Text", x = "September", y = "United Airlines",
           label = "Visualisation: Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt", fontface = "bold")
