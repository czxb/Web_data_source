#ggfortify包：一行R代码实现繁琐的可视化
##安装
#library(devtools)
#install_github('sinhrks/ggfortify')
library(ggfortify)
#主成分分析
df <- iris[c(1,2,3,4)]
dim(df)
autoplot(prcomp(df))
autoplot(prcomp(df), data = iris, colour = "Species")
autoplot(prcomp(df), data = iris, colour = "Species", label = TRUE, label.size = 3)
autoplot(prcomp(df), data = iris, colour = "Species", shape = FALSE, label.size = 3)
autoplot(prcomp(df), data = iris, colour = "Species", loadings = TRUE) #特征向量
autoplot(prcomp(df), data = iris, colour = "Species", loadings = TRUE, loadings.colour = 'orange', loadings.label = TRUE, loadings.label.size = 3)
#因子分析
d.factanal <- factanal(state.x77, factors = 3, scores = 'regression')
autoplot(d.factanal, data = state.x77, colour = 'Income')
autoplot(d.factanal, label = TRUE, label.size = 3, loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3, size = 0.3)
#K-mean聚类
autoplot(kmeans(USArrests, 3), data = USArrests)
autoplot(kmeans(USArrests, 3), data = USArrests, label = TRUE, label.size = 3, size = 0.3)
#其他聚类
library(cluster)
autoplot(clara(iris[-5], 3))
autoplot(fanny(iris[-5], 3), frame = TRUE)
autoplot(pam(iris[-5], 3), frame = TRUE, frame.type = 'norm')
#lfda(Fisher局部判别分析)
install_github("terrytangyuan/lfda")
library(lfda)
##Fisher局部判别分析(LFDA)
model <- lfda(iris[-5], iris[5], 4, metric = 'plain')
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
##非线性核Fisher局部判别分析(KLFDA)
model <- klfda(kmatrixGauss(iris[-5]), iris[5], 4, metric = "plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
#半监督Fisher局部判别分析（SELF）
model <- self(iris[-5], iris[,5], beta = 0.1, r = 3, metric = "plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = "Species")
##时间序列的可视化
#ts对象
data("AirPassengers")
autoplot(AirPassengers, ts.colour = 'orange', ts.linetype = 'dashed')
#多变量时间序列
library(vars)
data("Canada")
autoplot(Canada)
autoplot(Canada, facets = FALSE)
#其他时间序列类别
library(xts)
autoplot(as.xts(AirPassengers), ts.colour = 'green')
library(timeSeries)
autoplot(as.timeSeries(AirPassengers), ts.colour = 'blue')
autoplot(AirPassengers, ts.geom = 'bar', fill = 'pink')
autoplot(AirPassengers, ts.geom = 'point', shape = 3)
#forecast包
library(forecast)
d.arima <- auto.arima(AirPassengers)
d.forecast <- forecast(d.arima, level = 95, h = 50)
autoplot(d.forecast)
autoplot(d.forecast, ts.colour = 'red', predict.colour =  'orange', predict.linetype = "dashed", conf.int = FALSE) #好像失灵了
#vars包
library(vars)
d.vselect <- VARselect(Canada, lag.max = 5, type = "const")$selection[1]
d.var <- VAR(Canada, p = d.vselect, type = 'const')
autoplot(predict(d.var), n.ahead = 50, ts.colour = 'green', predict.colour = 'red', predict.linetype = "dashed")
#changepoint包
library(changepoint)
autoplot(cpt.meanvar(AirPassengers), cpt.colour = 'blue', cpt.linetype = 'solid')
#strucchange包
library(strucchange)
autoplot(breakpoints(Nile~1), ts.colour = 'blue', ts.linetype = 'dashed', cpt.colour = 'orange', cpt.linetype = "solid")
#dlm包
library(dlm)
form <- function(theta){
  dlmModPoly(order = 1, dV = exp(theta[1]), dW = exp(theta[2]))
}
model <- form(dlmMLE(Nile, parm = c(1,1), form)$par)
filtered <- dlmFilter(Nile, model)
autoplot(filtered)
autoplot(filtered, ts.linetype = "dashed", fitted.colour = 'blue')
smoothed <- dlmSmooth(filtered)
autoplot(smoothed)
p <- autoplot(filtered)
autoplot(smoothed, ts.colour = 'blue', p = p)
#KFAS包
library(KFAS)
model <- SSModel(
  Nile ~ SSMtrend(degree = 1, Q = matrix(NA)), H = matrix(NA)
)
fit <- fitSSM(model = model, inits = c(log(var(Nile)), log(var(Nile))), method = "BFGS")
smoothed <- KFS(fit$model)
autoplot(smoothed)
#使用smoothing = 'none'可以画出过滤后的结果
filtered <- KFS(fit$model, filtering = "mean", smoothing = 'none')
autoplot(filtered)
trend <- signal(smoothed, states = "trend")
p <- autoplot(filtered)
autoplot(trend, ts.colour = 'orange', p = p)
#stats包
library(stats)
autoplot(stl(AirPassengers, s.window = 'periodic'), ts.colour = 'blue')
autoplot(acf(AirPassengers, plot = FALSE))
autoplot(acf(AirPassengers, plot = FALSE), conf.int.fill = 'orange', conf.int.value = 0.8, conf.int.type = 'ma')
autoplot(spec.ar(AirPassengers, plot = F))
ggcpgram(arima.sim(list(ar = c(0.7, -0.5)), n = 50))
library(forecast)
ggtsdiag(auto.arima(AirPassengers))
gglagplot(AirPassengers, lags = 4)
