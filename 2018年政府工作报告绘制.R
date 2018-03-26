#rvest爬取文章内容
#jiebaR用于分词
#wordcloud2用于文本可视化
#文章爬取
library(rvest)
library(jiebaR)
library(wordcloud2)
setwd("~/Desktop")
# 2018年政府工作报告的网址为：http://www.gov.cn/premier/2018-03/22/content_5276608.htm
#我们需要爬取的文字就在这个标签里：<div class="pages_content" id="UCAP-CONTENT">
url <- "http://www.gov.cn/premier/2018-03/22/content_5276608.htm"
web <- read_html(url, encoding = "utf-8")
position <- web %>% html_nodes("div.pages_content") %>% html_text()
#分词
engine_s <- worker(stop_word = "stopwords.txt") #初始化分词引擎并加载停用词
seg <- segment(position, engine_s) #分词
f <- freq(seg) #统计词频
f <- f[order(f[2], decreasing = T),] #根据词频降序排列
head(f)
#可视化
wordcloud2(f, size = 0.8, shape = "star")
wordcloud2(f, size = 1.3, backgroundColor = "black")
letterCloud(f, word = "Dang", size = 1)