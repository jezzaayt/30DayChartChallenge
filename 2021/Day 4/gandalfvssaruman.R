library("dplyr")
library("ggplot2")
library("treemap")

# using dataset from 
# https://www.kaggle.com/mokosan/lord-of-the-rings-character-data

#Words spoken by Ainur  
#Holy Ones immortal  in LOTR. 
# Main characters famously played by Christropher Lee and Ian McKellen

df <- read.csv("WordsByCharacter.csv")
head(wbc)
characters <- c("Gandalf", "Saruman")
wbc <- df %>% select(Film, Chapter, Character, Race, Words) %>% filter(Race == "Ainur")
wbc

#Clusted Column to show the amount of words spoken 
ggplot(wbc, aes(Film, Words, fill = Character)) + geom_bar(stat="identity", position="dodge") +
  labs(title="Clustered Column Chart words spoken by Ainur Character") +
  theme_bw()+
  scale_y_continuous(breaks = c(0,25,50, 100, 200, 250, 300, 400, 500, 550))
  


treemap(wbc, index = c("Film", "Character"),
        vSize = "Words",
        type = "index",
        bg.labels=c("transparent"),
        align.labels=list(
          c("center", "center"), 
          c("center", "bottom")
        ),
        inflate.labels=F,
        title = "Words spoken by Ainurs per film"
)
treemap(wbc, index = c("Character"),
        vSize = "Words",
        type = "index",
        bg.labels=c("transparent"),
        align.labels=list(
          c("center", "center"), 
          c("center", "bottom")
        ),
        inflate.labels=F,
        title="Words per Ainur race in Lord of the Rings"
)
