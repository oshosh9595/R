install.packages("tidyverse")
install.packages("ggplot2")

library(tidyverse)
library(readxl)
library(ggplot2)

df <- read_excel("./data/시군구_성_월별_출생_19972021.xlsx")

View(df)

df2 <- df %>%
  filter(!is.na(시점)) %>%
  select(시점, 전국) %>%
  separate(시점, into = c("년도", "월")) #이런구조가 자주사용 일상에서

df2 <<- df2 %>%
  group_by(월) %>%
  summarise(평균출생수 = mean(전국)) 

df2 %>% 
  qplot(x=월, y=평균출생수, data=.)
