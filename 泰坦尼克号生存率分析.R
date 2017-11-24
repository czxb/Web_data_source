## 泰坦尼克号生存率分析
## 知乎专栏文章学习笔记
## 舱位等级与生存率的关系
setwd("~/Desktop")
Titanic <- read.csv("Titanic.csv", header = T, stringsAsFactors = F)
library(dplyr)
train <- select(Titanic, Survived, Pclass)
train <- filter(train, !is.na(Survived), !is.na(Pclass)) ## 过滤掉缺失值
Pclass_Survived <- table(train$Survived, train$Pclass)
Pclass_Survived ##123表示舱位等级，01表示生存和死亡
Pclass_Survived_rate <- round((Pclass_Survived[2,]/colSums(Pclass_Survived)), 2)
Pclass_Survived_rate  ##生存率
## 绘制图表
Pclass <- c(1,2,3)
rate <- c(Pclass_Survived_rate)
rate <- data.frame(Pclass, rate)
library(ggplot2)
(p <- ggplot(data = rate, aes(x = Pclass, y = rate)) + geom_point() + geom_line(size = 0.8))
## 修改坐标轴间距
(p <- p + scale_x_continuous(breaks = seq(0,3,1)))
## 年龄与生存率的关系
train2 <- select(Titanic, Survived, Age)
train2 <- filter(train2, !is.na(Survived), !is.na(Age))
arrange(train2, Age)
## 对年龄进行分组编码
train2$Age_cat[train2$Age <= 7] <- "child"
train2$Age_cat[train2$Age > 7 & train2$Age <= 25] <- "teenager"
train2$Age_cat[train2$Age > 25 & train2$Age <= 45] <- "middle_age"
train2$Age_cat[train2$Age > 45 & train2$Age <= 65] <- "postadolescent"
train2$Age_cat[train2$Age > 65] <- "the_aged"
head(train2)
train2$Age_cat <- factor(train2$Age_cat, ordered = T, levels = c("child", "teenager", "middle_age", "postadolescent", "the_aged"))
Age_survived <- group_by(train2, Age_cat)
head(Age_survived)
Age_survived_rate <- summarise(Age_survived, count = n(), rate1 = sum(Survived), rate2 = round((rate1/count), 2))
Age_survived_rate
data = as.data.frame(Age_survived_rate)
(q <- ggplot(data = data, aes(x = Age_cat, y = rate2)) + geom_point())

#### 性别与生存率的关系
train3 <- select(Titanic, Survived, Sex)
train3 <- filter(train3, !is.na(Survived), !is.na(Sex))
arrange(train3, Sex)
Sex_survived <- group_by(train3, Sex)  
Sex_survived_rate <- summarise(Sex_survived, count = n(), rate1 = sum(Survived), rate2 = round((rate1/count), 2))
Sex_survived_rate  
ggplot(Sex_survived_rate, aes(Sex, rate2)) + geom_bar(stat = "identity", fill = "lightblue", width = 0.5) + geom_text(aes(label = rate2), vjust = 1.5, colour = "black")  
  
#### 总生存率
Survived_rate <- summarise(Titanic, count = n(), sum = sum(Survived), rate2 <- round((sum/count), 2))
Survived_rate  