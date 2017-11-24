#ggedit：交互式ggplot图形参数修改
## 查看最近一天下载量top10包
install.packages("cranlogs")
library(cranlogs)
cran_top_downloads()
cran_ggplot2 <- cran_downloads(packages = "ggplot2", from = "2012-11-17", to = "2017-11-17")
sum(cran_ggplot2) #查看五年来的累计下载量（似乎这两句无法运行）
## ggedit是一款交互式调整图形参数的ggplot2扩展包工具
install.packages("ggedit")
library(ggedit)
library(ggplot2)
p <- ggplot(mtcars, aes(hp, wt)) + geom_point() + geom_smooth()
p2 <- ggedit(p)
##然后就会调出交互式界面