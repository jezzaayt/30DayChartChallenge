library(tidyverse)
library(ggrepel)
#data source: https://data.london.gov.uk/dataset/traffic-flows-borough
#license of the data: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/2/
df <- readxl::read_xls("traffic-flow-borough.xls", sheet = "Traffic Flows - Cars")
df
df <- na.omit(df)
df
df2<- df %>% pivot_longer(cols = c(`2019`,`2020`),
                          names_to = "Dates", values_to = "Count") 
df2 <- df2 %>% select(`Local Authority`, Dates, Count)
areas <- c("Wales", "Scotland", "England")
df2 <- df2 %>% filter(`Local Authority` %in% areas)
df2$Dates <- as.numeric(as.character(df2$Dates))
df2$Count <- as.numeric(as.character(df2$Count))
ggplot(df2, aes(x=Dates, y = Count , color = `Local Authority`)) + 
  geom_point()+geom_line() +scale_y_continuous(labels = scales::label_comma()) + 
  scale_x_continuous(breaks = c(2019, 2020)) + geom_label_repel(aes(label= Count)) +
  labs(title = "Comparison of the Amount of Car Traffic Flow in 2019 vs 2020",
       subtitle = "Data source: data.london.gov.uk", 
       caption = "Visualisation: Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt") + theme_classic() + theme_minimal()

