# 직장인 => 생상선과 협역 => 보고서(이해가능)
# 결과물은 누군가가 이해 => git, github

# 회귀 => 값을 예측하는 것
# 캘리포니아 집 값을 예측
## 단순 회귀

## 예측을 어떻게 하는거야?
# 1. 데이터를 불러오기 확인 -> 시각적인 확인
# 2-1. 전처리 과정 -> NA
# 2-2. 후처리 과정 -> 표준화와 정규화
# 3. 데이터를 분리 -> 학습와 검증
# 4. 학습 -> 기울기와 절편
# 5. 검증 -> 모델을 검증 

library(tidyverse)
library(reshape2)

setwd("D:/osh/works")
housing = read.csv("./data/housing.csv")
head(housing)

colnames(housing)

#경향성 확인
ggplot(data = melt(housing), mapping = aes(x = value)) + 
  geom_histogram(bins = 30) +
  facet_wrap(~variable, scales = 'free_x' )

#히스토그램 데이터는 평균을 쓰지말자 중앙값쓰자
#2. 전처리
housing$total_bedrooms[is.na(housing$total_bedrooms)] <- median(housing$total_bedrooms, na.rm=TRUE)
sum(is.na(housing))

housing$mean_bedrooms <- housing$total_bedrooms/housing$households
housing$mean_rooms <- housing$total_rooms/housing$households

drops <- c('total_bedrooms', 'total_rooms')
housing <- housing[ , !(names(housing) %in% drops)]

categories <- unique(housing$ocean_proximity)
cat_housing <- data.frame(ocean_proximity = housing$ocean_proximity)
head(cat_housing)

for(cat in categories){
  cat_housing[,cat] = rep(0, times= nrow(cat_housing))
}

for(i in 1:length(cat_housing$ocean_proximity)){
  cat <- as.character(cat_housing$ocean_proximity[i])
  cat_housing[,cat][i] <- 1
}

head(cat_housing)
tail(cat_housing)

cat_columns <- names(cat_housing)
keep_columns <- cat_columns[cat_columns != 'ocean_proximity']
cat_housing <- select(cat_housing,one_of(keep_columns))
tail(cat_housing)

drops <- c('ocean_proximity','median_house_value')
housing_num <-  housing[ , !(names(housing) %in% drops)]
head(housing_num)

scaled_housing_num <- scale(housing_num)
head(scaled_housing_num)

cleaned_housing <- cbind(cat_housing, scaled_housing_num, median_house_value=housing$median_house_value)
head(cleaned_housing)

#train 학습용 
#test  검증용
# 3. 데이터를 분리 -> 학습과 검증
set.seed(42)
sample <- sample.int(n = nrow(cleaned_housing), size = floor(.8*nrow(cleaned_housing)), replace = F)
train <- cleaned_housing[sample, ] #just the samples
test  <- cleaned_housing[-sample, ] #everything but the samples
head(train)

nrow(train) + nrow(test) == nrow(cleaned_housing)

#k_fold 교차검증
glm_house = glm(median_house_value~median_income+mean_rooms+population, data=cleaned_housing)
k_fold_cv_error = cv.glm(cleaned_housing , glm_house, K=5)
k_fold_cv_error$delta

#XGBOOST
