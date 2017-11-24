# jiebaR分词包
## 分词函数worker
## worker(type = "mix", dict = DICTPATH, hmm = HMMPATHH, user = USERPATH, idf = IDFPATH, stop_word = STOPPATH, write = T, qmax = 20, topn = 5, encoding = "UTF-8", detect = T, symbol = F, lines = 1e+05, output = NULL, bylines = F, user_weight = "max")
setwd("~/Desktop")
library(jiebaR)
engine <- worker()
words <- "在连续发生的多种原因中，属于保险责任的原因在前，属于除外责任的原因在后，前后者又有因果关系，则保险人就要承担赔偿责任。公众号，R语言" #注意公众号和R语言被分为了两个词
segment(words, engine)
engine <= words #与上面的命令等价
#添加用户自定义词或词库
##方法一：new_user_word()函数：
engine_new_word <- worker()
new_user_word(engine_new_word, c("公众号", "R语言"))
segment(words, engine_new_word)
##方法二：user参数添加词库（先用txt建立一个词典文件）：
engine_user <- worker(user = 'dictionary.txt')
segment(words, engine_user)
##在使用词库的胡哈也可以使用new_user_word()函数：
new_user_word(engine_new_word, scan("dictionary.txt", what = "",sep = "\n"))
segment(words, engine_new_word)
##注意：
#词库的第一行一定要空着，都则第一个词可能会消失；
##删除停用词
engine_s <- worker(stop_word = "stopwords.txt")
segment(words, engine_s)
engine_s <- worker(stop_word = "stopwords.txt", user = "dictionary.txt")
segment(words, engine_s)
##统计词频
freq(segment(words, engine_s))
##词性标注（在分词的时候会加上词性）
#方法一：好像已经失效了
qseg[words]
qseg <= words
#方法二：
tagger <- worker(type = "tag")
tagger <= words
#提取关键词
keys <- worker(type = "keywords", topn = 2)
keys <= words
keys <- worker(type = "simhash", topn = 2)
keys <= words