##ggplot2是如何通过颜色信号来对多边形进行填充的？
##geom_ploygon()图层
##geom_polygon()需要显式声明的参数至少需要四个：
#data(地理信息数据框)
#long(经度简写)
#lat(纬度简写)
#group(多边形分组变量)
##即该图层至少需要这四个参数才能保证可以输出一张具有完整地理信息的地图出来（注意：完整的地理信息边界并不代表行政边界，地理信息边界仅仅描述了实际存在的地理轮廓）。
#国界线则是需要在group的基础上，施加id。
library(maps)
library(ggplot2)
library(ggthemes)
library(RColorBrewer)
world_map = map_data("world")
head(world_map)
ggplot(world_map) + geom_polygon(aes(x = long, y = lat))
#以上是未指定分组变量，所以自然映射出现了这种情况，即软件将所有点全部连在一起。
ggplot(data = world_map) + geom_polygon(aes(x = long, y = lat, group = group), colour = "white")
#指定分组之后，勾勒出了地理信息轮廓，事实上此时并不知道国家的分界线
world_map[world_map$region == "Taiwan",]$region <- "China"
ggplot(data = world_map) + 
  geom_polygon(aes(x = long, y = lat, group = group, fill = region), color = "grey95") + 
  theme_map() %+replace% theme(legend.position = "none")
#也可以将颜色映射在轮廓线上
ggplot(data = world_map) + 
  geom_polygon(aes(x = long, y = lat, group = group, colour = region), fill = "grey95") + 
  theme_map() %+replace% theme(legend.position = "none")

##更有意义的做法是依据不同国家或者地区的某个指标进行连续渐变填充或者离散颜色填充
region <- unique(world_map$region)
zhibiao <- runif(251, 0, 500)
mydata <- data.frame(region, zhibiao)
mydata$factor <- cut(mydata$zhibiao, breaks = c(0, 100, 200, 300, 400, 500), labels = c("0~100", "100~200", "200~300", "300~400", "400~500"), order = TRUE, include.lowest = FALSE)
mynewmapdata <- dplyr::arrange(merge(world_map, mydata), group, order) 
##上面的最后是进行重新排序
ggplot(data = mynewmapdata) + 
  geom_polygon(aes(x = long, y = lat, group = group, fill = zhibiao), colour = "grey95") + 
  scale_fill_gradient(low = "white", high = "steelblue") + 
  theme_map() %+replace% theme(legend.position = "none")

ggplot(data = mynewmapdata) + 
  geom_polygon(aes(x = long, y = lat, group = group, fill = factor), colour = "grey95") + 
  scale_fill_brewer(palette = "Greens", guide = FALSE) + 
  theme_map() %+replace% theme(legend.position = "none")