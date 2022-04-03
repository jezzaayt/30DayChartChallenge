library(tidyverse)
library(echarts4r)
library(echarts4r.assets)
library(cowplot)
library(grid)
library(combineWidgets)
# dolphin svg is from https://svgsilh.com/image/159157.html
# Which sttates it is a creative commons license

data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-12-18/allCetaceanData.csv')
data

df <- data %>% select (species, sex)
df
df <- df %>% count(species, sex)
dolphin_path = c("path://M4980 8276 c-200 -26 -488 -90 -554 -123 -62 -31 -106 -88 -106 -135
                 1 -68 77 -159 210 -251 41 -28 252 -160 468 -293 l394 -242 51 -84 c27 -46 68
                 -121 90 -168 35 -74 41 -95 45 -176 8 -148 -36 -263 -168 -439 -37 -49 -91
                 -128 -120 -175 -29 -47 -197 -301 -374 -565 -711 -1061 -944 -1441 -1196
                 -1950 -71 -143 -153 -323 -184 -400 -60 -155 -64 -165 -131 -379 -81 -259
                 -181 -426 -420 -704 -76 -89 -372 -419 -429 -479 -6 -7 -346 -76 -756 -153
                 -1774 -337 -1619 -304 -1707 -356 -51 -30 -93 -82 -93 -116 0 -32 34 -76 69
                 -89 70 -27 136 -29 526 -18 1011 31 1693 -55 2155 -273 204 -96 343 -199 550
                 -409 162 -164 224 -209 375 -270 131 -53 247 -23 295 75 55 115 66 387 20 531
                 -60 189 -199 388 -369 530 -72 60 -121 123 -142 184 -15 43 9 97 59 131 20 14
                 199 147 397 296 704 529 920 678 1147 791 l86 43 84 -20 c162 -38 254 -45 558
                 -45 162 1 358 6 435 13 1062 96 2299 438 3403 943 95 43 175 79 177 79 4 0 -1
                 -45 -26 -235 -59 -444 -181 -844 -409 -1340 -89 -193 -108 -268 -90 -346 14
                 -58 61 -105 116 -115 45 -8 141 7 215 35 69 26 285 156 431 258 742 521 1187
                 1284 1248 2141 6 79 8 148 4 153 -8 13 0 12 89 -20 45 -16 114 -34 153 -40
                 l71 -12 64 -81 c145 -184 454 -411 624 -457 63 -17 164 -13 210 8 48 22 106
                 81 134 137 23 45 61 167 61 197 0 10 12 34 27 54 23 30 27 44 26 102 -2 106
                 -27 181 -143 424 l-109 227 39 63 c81 126 135 311 171 577 11 85 29 220 40
                 300 49 371 31 654 -56 885 -176 462 -342 744 -572 965 -328 317 -789 500
                 -1468 584 -264 33 -387 28 -791 -29 -572 -82 -972 -186 -2030 -531 -193 -63
                 -353 -114 -356 -114 -2 0 -58 30 -124 66 -300 166 -698 353 -1164 547 -481
                 200 -654 267 -731 283 -104 21 -369 26 -499 10z")


dolphin_path
df <- df %>% arrange(n)
df

df_m <- df %>% filter(df$sex == "M") %>% e_charts(species) %>% e_pictorial(n, symbol = dolphin_path,symbolRepeat =TRUE, z=-1, symbolSize = c(20,20)) %>% 
  e_theme("westeros") %>% e_x_axis(splitLine = list(show=FALSE)) %>%
  e_flip_coords()%>% e_labels(fontSize = 12, position="right") %>% e_legend(FALSE)%>% 
  e_title("Visualisation By Jeremy A@JezzaAyt\nCount of male species in Cetacean dataset")
df_f <- df %>% filter(df$sex == "F") %>% e_charts(species) %>% e_pictorial(n, symbol = dolphin_path,symbolRepeat =TRUE, z=-1, symbolSize = c(20,20)) %>% 
  e_theme("westeros") %>% e_x_axis(splitLine = list(show=FALSE)) %>%
  e_flip_coords()%>% e_labels(fontSize = 12, position="right") %>% e_legend(FALSE) %>% 
  e_title("Count of female species in Cetacean dataset")
df_m
df_f
caption <- e_chart() %>% e_title("Jeremy A\nhttps://github.com/jezzaayt\n@JezzaAyt")
caption

dfs <- manipulateWidget::combineWidgets(title ="Data used in Free Willy and Finger by the Numbers July 2017 " ,df_m, df_f)
dfs

