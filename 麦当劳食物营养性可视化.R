##麦当劳食物营养性可视化
library(ggplot2)
library(dplyr)
library(plotly)
library(RColorBrewer)
library(devtools)
library(yarrr)
library(tidyr)
library(gridExtra)
library(viridis)
setwd("~/Desktop")
menu <- read.csv("menu.csv")
##查看缺失值
library(mice)
md.pattern(menu)
##从上图可以看出没有缺失值
##食物类别
m <- list(l = 50, r = 50, b = 100, t = 100, pad = 4)
marker <- list(color = brewer.pal(9, "Set1"))
p <- plot_ly(x = menu$Category, marker = list(color = '#45171D'), type = "histogram") %>% layout(xaxis = list(title = ""), yaxis = list(title = ""), autosize = T)
p
##食物卡路里与糖分的关系
d1 <- menu %>% ggplot(aes(x = Sugars, y = Calories)) + 
  stat_density_2d(geom = "polygon", aes(fill = ..level..), h = c(100, 1500), contour = T) +
  scale_fill_viridis(option = "magma")
d1
##碳水化物与卡路里
d2 <- menu %>% ggplot(aes(x = Carbohydrates, y = Calories)) + 
  stat_density_2d(geom = "tile", aes(fill = ..density..), h = c(100, 1500), contour = F) +
  scale_fill_viridis(option = "magma")
d2
##钠与卡路里
d3 <- menu %>% ggplot(aes(x = Sodium, y = Calories)) + 
  stat_density_2d(geom = "tile", aes(fill = ..density..), h = c(3000, 1500), contour = F) +
  scale_fill_viridis(option = "magma")
d3
##胆固醇与卡路里
d4 <- menu %>% ggplot(aes(x = Cholesterol, y = Calories)) + 
  stat_density_2d(geom = "tile", aes(fill = ..density..), h = c(600, 1500), contour = F) +
  scale_fill_viridis(option = "magma")
d4
##膳食纤维与蛋白质
d5 <- menu %>% ggplot(aes(x = Dietary.Fiber, y = Protein)) + 
  stat_density_2d(geom = "tile", aes(fill = ..density..), h = c(5, 70), contour = F) +
  scale_fill_viridis(option = "magma") + 
  scale_x_continuous(limits = c(0, 8))
d5
##脂肪的热量与卡路里之间的关系
p1 <- plot_ly(menu, x = ~Calories, type = "histogram", histogram = "probability", name = "Calories", alpha = 0.6) %>% add_histogram(x = ~Calories.from.Fat, name = "Calories From Fat", alpha = 0.6) %>% layout(barmode = "overlay")
p1
##食物类别与卡路里
new_col <- c("grey50", "blue", "hotpink", "Magenta", "seagreen", "violet", "brown", "maroon", "navyblue")
plot_ly(x = menu$Category, y = menu$Calories, color = menu$Category, colors = new_col, type = "box") %>% layout(xaxis = list(title = ""), yaxis = list(title = ""), showlegend = F, autosize = T)
##食物类别与蛋白质含量
plot_ly(x = menu$Category, y = menu$Protein, color = menu$Category, colors = new_col, type = "box") %>% layout(xaxis = list(title = ""), yaxis = list(title = ""), showlegend = F, autosize = T)
##食物种类中的鸡鱼类的蛋白质含量
library(ggrepel)
menu %>% select(Category, Item, Protein, Total.Fat) %>% arrange(desc(Protein)) %>% filter(Category == "Chicken & Fish") %>% ggplot(aes(x = Item, y = Protein, col = Item)) + 
  geom_point(size = 3) + 
  theme(legend.position = "none", axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  geom_label_repel(aes(label = substr(Item, 1, 20)), size = 2) + 
  labs(title = "High Protein/Fat Item in Chicken & Fish Category") + geom_bar(aes(y = Total.Fat), alpha = 0.5, stat = "identity")
##碳水化合物含量与食物种类的可视化分析
plot_ly(x = menu$Category, y = menu$Carbohydrates, color = menu$Category, colors = new_col, type = "box") %>% layout(xaxis = list(title = ""), yaxis = list(title = ""), showlegend = F, autosize = T)
##碳水化合物与卡路里之间的关系
plot_ly(x = menu$Calories, y = menu$Carbohydrates, type = "scatter", mode = "markers", marker = list(color = ifelse(menu$Calories>500, "red", "blue"), opacity = 0.5, size = 20))
##食物类别和总脂肪的箱线图
plot_ly(x = menu$Category, y = menu$Total.Fat, color = menu$Category, colors = new_col, type = "box") %>% layout(xaxis = list(title = ""), yaxis = list(title = ""), showlegend = F, autosize = T)
##总脂肪、脂肪的热量和饱和脂肪三维比较分析图：
m1 <- menu %>% select(Total.Fat, Calories.from.Fat, Saturated.Fat)
m2 <- as.matrix(m1)
colnames(m2) <- NULL
plot_ly(z = ~m2) %>% add_surface() %>% layout(scene = list(xaxis = list(title = "Total.Fat"), yaxis = list(title = list(title = "Calories from Fat"), zaxis = list(title = "Saturated Fat"))))
