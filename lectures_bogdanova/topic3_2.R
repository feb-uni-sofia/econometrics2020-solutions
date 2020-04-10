# Import data ----
rm(list=ls())
# http://faculty.marshall.usc.edu/gareth-james/ISL/data.html
dd=read.csv("https://raw.githubusercontent.com/feb-uni-sofia/econometrics2020-solutions/master/data/Advertising.csv",na.strings=c(""," ","NA"), stringsAsFactors = F)

# Make a table of two variables only
dd.new=data.frame(Y=dd$sales*1000,X=dd$TV)
attach(dd.new)
# Visualize data via a scatterplot
windows()
plot(X,Y,pch=19,col="blue",main="Sales vs. TV budget")

# Estimate parameters of LR ----
xbar=mean(X)
ybar=mean(Y)
(beta2=sum((X-xbar)*(Y-ybar))/sum((X-xbar)^2))
(beta1=ybar-beta2*xbar)
# Use the lm function 
eq=lm(Y~X)
names(eq)
eq$coefficients
# What is the expected sales turnover if the TV budget is $80?
coef(eq)[1]+coef(eq)[2]*80
summary(eq)
# Visualize actual vs fitted 
windows()
plot(X,Y,pch=19,col="blue", main="Actual vs. fitted values")
lines(X,eq$fitted.values,lwd=2,col="red")

# OLS Assumptions ----
mean(eq$residuals)
windows()
plot(eq$residuals,type="l",col="blue",lwd=2)
library(dplyr)
windows()
plot(lag(eq$residuals,1),eq$residuals,pch=19,col="blue")

