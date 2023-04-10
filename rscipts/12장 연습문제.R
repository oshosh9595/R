#12장 연습문제 1
library(gmodels)
getwd() #폴더 확인
setwd("D:/osh/works") #폴더지정
smoke <- read.csv("./data/smoke.csv", header = T)
head(smoke)

smoke$education2[smoke$education == 1] <- "1. 대졸"
smoke$education2[smoke$education == 2] <- "2. 고졸"
smoke$education2[smoke$education == 3] <- "3 .중졸"
smoke$smoking2[smoke$smoking == 1] <- "1.과대흡연"
smoke$smoking2[smoke$smoking == 2] <- "2.보통흡연"
smoke$smoking2[smoke$smoking == 3] <- "3.비흡연"


table(smoke$education2, smoke$smoking2)

CrossTable(smoke$education2, smoke$smoking2, chisq = T)

#12장 연습문제2

data <- read.csv("./data/cleanData.csv", fileEncoding = "euc-kr")
str(data)

#euc-kr, cp949, ko-KR <- 국가표준(cp949)  , ko-KR(euc-kr) -> euc-KR -> unicode(euc-KR)
#UTF-8, Unicode

x <- data$position
y <- data$age3

plot(x,y, abline(lm(y~x)))

CrossTable(x,y,chisq = T)

#12장 연습문제3
result <- read.csv("./data/response.csv", header = T)
str(result)

result$job2[result$job==1] <- "1. 학생"
result$job2[result$job==2] <- "2. 직장인"
result$job2[result$job==3] <- "3. 주부"
result$response2[result$response==1] <- "1.무응답"
result$response2[result$response==2] <- "2.낮음"
result$response2[result$response==3] <- "3.높음"

table(result$job2, result$response2)

chisq.test(result$job2, result$response2)
#동질성검사는 카이제곱으로
