getwd() #폴더 확인

dataset <-  read.csv("./data/dataset.csv", header = T) #T - tap 사이즈
dataset
print(dataset) #수업용 인데 이거잘안쓴다
View(dataset) # 이거 쓰기

head(dataset) # 앞쪽데이터
tail(dataset) # 뒤쪽데이터

sum(dataset$price, na.rm = T)
price2 <- na.omit(dataset$price) #결측치 지우기? na있는것들은 이렇게함수로
price2

#names(dataset) --의미없음
#attributes(dataset) --의미없음
str(dataset)

x <- dataset$age 

plot(dataset$price)
#dataset[""] <- 딕셔너리 
dataset[1] #R은 0부터가아니고 1부터
dataset[c("job", "price")] #c 는 백터

summary(dataset)

