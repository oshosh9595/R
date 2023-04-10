# 예제 : 캘리포니아 집값 데이터

library(tidyverse)
library(reshape2)

setwd("D:/osh/works")
house <- read.csv("./data/housing.csv")

# 1. 통계청 출산 데이터(시게열, 회귀)
# 2. ~ 집 값 데이터(캘리포니아) => 대표적인 회귀  [보스터집값은 쓰지말고]
# 3. 손글씨 분류(비정형) => 분류(0~9분류) / iris 분류
# 4. diamond

head(house)

summary(house)

## 데이터 시각화(데이터 확인을 위한) <- 나중에
par(mfrow=c(2,5))
colnames(house)
#ggplot(data = melt(house), mapping = aes(x = value))
#       + geom_histogram(bins = 30)
#       + facet_wrap(-variable, scale = "free_x" ))

## 결측값처리
house$mean_bedrooms = house$total_bedrooms / house$households
house$mean_rooms = house$total_rooms / house$households

drop = c('total_bedrooms', 'total_rooms')

house = house[ , !(names(house) %in% drop)]

head(house)
str(house) #타입 맞추기
## (코딩) 전처리(상식을 사용햇서 가정에 대한 데이터를 별도로 분리)
categories = unique(house$ocean_proximity)
categories

cat_house = data.frame(ocean_proximity = house$ocean_proximity)
cat_house
for(cat in categories) {
  cat_house[,cat] = rep(0, time=nrow(cat_house))
}
cat_house
head(cat_house)

for(i in 1:length(cat_house$ocean_proximity)) {
  cat = as.character(cat_house$ocean_proximity[i])
  cat_house[,cat][i] = 1
}
head(cat_house)
