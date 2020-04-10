## You need to run the install.packages once (per computer), otherwise you will get 
## errors when you run library(fBasics), library(dplyr)
## So uncomment the following line, run it, then comment it again
## install.packages(c("fBasics", "dplyr"))

library(fBasics)
library(dplyr)
# Hypothetical example ----
x=seq(from=80, to=260, by=20)

# Sample 1 
y1=c(65,80,84,80,110,130,145,135,155,180)
plot(x,y1,col="blue",pch=19)
eq1=lm(y1~x)
coef(eq1)
lines(x,eq1$fitted.values,col="red",lwd=2)
plot(eq1$residuals,col="blue",pch=19)

# Sample 2 & Sample 3
# Complete by yourself the script following the same steps as those for Sample 1

# S&P 500 example ----

# Make sure the workspace is clean
rm(list=ls())
#Import data
dd=read.csv("https://raw.githubusercontent.com/feb-uni-sofia/econometrics2020-solutions/master/data/sp.csv", stringsAsFactors = F)
sapply(dd,class)
# Fix dates' class
dd$Date[1:5]
library(lubridate)
dd$Date=mdy(dd$Date)

# Visual representation
plot(dd$Date,dd$Adj.Close,type="l",main="S&P500")
hist(dd$Adj.Close)

# Transform data
library(dplyr)
dd$Adj.Closel1=lag(dd$Adj.Close,1)
dd=dd[-1,]
dd$logRet=log(dd$Adj.Close/dd$Adj.Closel1)
plot(dd$Date,dd$logRet,type="l",main="S&P500 log rets")
hist(dd$logRet)
boxplot(dd$logRet)
qqnorm(dd$logRet)

# Visualize unconditional mean value
plot(dd$Date,dd$logRet,type="l",main="S&P500 log rets")
lines(dd$Date,rep(1,nrow(dd))*mean(dd$logRet),col="red",lwd=2)

# Obtain summary /descriptive/ stats
basicStats(dd$logRet)

