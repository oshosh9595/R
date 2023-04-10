#7장 2, 3, 4 번
#2번 dateset2의 resident 칼럼을 대상으로 na 제거 후 저장
getwd()

install.packages("ggplot2")
install.packages("lattice")

library(ggplot2)
library(lattice)

dataset2 <- read.csv("./data/dataset.csv", header = T)
View(dataset2)

summary(dataset2$resident)
sum(dataset2$resident)

resident2 <- na.omit(dataset$resident)
sum(resident2)
#3번 gender 1->남자, 2->여자 gender2추가 하고 파이차트로 결과확인
dataset2$gender2[dataset2$gender == 1] <- '남자'
dataset2$gender2[dataset2$gender == 2] <- '여자'
head(dataset2[c("gender", "gender2")])

gender_freq <- table(dataset2$gender2)
pie(gender_freq, labels = c("남자", "여자"))

#4번 age 칼럼을 30세이하는 1, 30~55세 2, 55이상은 3으로 리코딩 age3컬럼에추가 age, age2, age3으로 칼럼만확인
dataset2$age1[dataset2$age <= 30] <- "1"
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- "2"
dataset2$age3[dataset2$age > 55 ] <- "3"
head(dataset2[c('age', 'age1', 'age2', 'age3')])

#8장
install.packages(lattice)
library(lattice)
install.packages(latticeExtra)
library(latticeExtra)


#1번
View(quakes)
View(SeatacWeather)

#수심을 3개영역을 범주화
depthgroup <- equal.count(quakes$depth, 3, overlap = 0)
View(depthgroup)

#규모을 2개영역을 범주화
magnitudegroup <-equal.count(quakes$mag, number=2, overlap=0)
View(magnitudegroup)

#3행2열 산점도 그래프
xyplot(lat ~ long | depthgroup * magnitudegroup, data = quakes, main="Fiji Earthquakes", ylab="latitude", xlab="longitude", pch="@",col=c("red","blue"), layout=c(2, 3))

#2번
xyplot(min.temp + max.temp ~ day | month, data=SeatacWeather, type="l", layout=c(1,3))
