#7장
getwd()

dataset <- read.csv("./data/dataset.csv", header = T) #header 쓴이유 불안감 데이터쓸떄 ? 옵션없이읽는게 나음
head(dataset)

dataset2 <- subset(dataset, price >=2 & price <= 8) #subset 맨첫번째인자값 
str(dataset2)

pos <- dataset2$position
cpos <- 6 - pos # 6을빼준이유 - 파생변수 - 결과가 백터로 나온다

dataset2$position <- cpos
dataset2$position[dataset2$position == 1] <- '1급'
dataset2$position[dataset2$position == 2] <- '2급'
dataset2$position[dataset2$position == 3] <- '3급'
dataset2$position[dataset2$position == 4] <- '4급'
dataset2$position[dataset2$position == 5] <- '5급'

range(dataset2$resident, na.rm = T)
#range(5) #이걸 모르겟다할떄는 ?range 이런걸쓰면 도움말이 나온다 - range 특징 범위를만들어준다
dataset2 <- subset(dataset2, !is.na(dataset2$resident))
head(dataset2)

dataset2$gender2[dataset2$gender == 1] <- '남자'
dataset2$gender2[dataset2$gender == 2] <- '여자'
pie(table(dataset2$gender2))

#Vector, Matrix, Table, DF
#1.하줄짜리 행 , 2.면, 3.컬럼에 적혀있는거 헤더머있는거
#4.테이블을이해시켜서 안쪽에 있는 것을 연산시킬수있는자료구조

#8장
library(lattice)
data(quakes)
##??equal.count 패키지 자세하게알려주는 ?
depthgroup <- equal.count(quakes$depth, number = 3, overlap = 0)
magnitudegroup <- equal.count(quakes$mag, number = 2, overlap = 0)

xyplot(lat ~ long | magnitudegroup * depthgroup, data = quakes)

install.packages("latticeExtra")
library(latticeExtra)
xyplot(min.temp + max.temp ~ day | month,
       data= SeatacWeather)
