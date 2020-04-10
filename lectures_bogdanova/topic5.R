# Import data ----
rm(list=ls())
# http://faculty.marshall.usc.edu/gareth-james/ISL/data.html

dd=read.csv("https://raw.githubusercontent.com/feb-uni-sofia/econometrics2020-solutions/master/data/Advertising.csv",na.strings=c(""," ","NA"), stringsAsFactors = F)
dd$sales=dd$sales*1000
dd=dd[,-1]

# Estimate multiple linear regression equation ----
eq1=lm(sales~TV+radio+newspaper, data=dd)
summary(eq1)
# Feature and engineering and feature selection ----
# Introduce synergy effects
dd$S1=dd$TV*dd$radio
dd$S2=dd$TV*dd$newspaper
dd$S3=dd$radio*dd$newspaper
dd$S4=dd$TV*dd$radio*dd$newspaper
# Visualize the correlation matrix
library(psych)
windows()
cor.plot(dd,numbers=T,las=2)
# Feature selection
library(leaps)
fs=regsubsets(sales~.,data=dd,nvmax=7)
summary(fs)$which
names(summary(fs))
summary(fs)$adjr2
# Final choice and prediction ----
eq1=lm(sales~TV+radio+S1,data=dd)
eq2=lm(sales~TV+S1+S2+S4,data=dd)
eq3=lm(sales~TV+radio+newspaper+S1+S2,data=dd)
ddn=data.frame(TV=c(50,60,70),radio=c(40,25,5),newspaper=c(0,5,15))
ddn$S1=ddn$TV*ddn$radio
ddn$S2=ddn$TV*ddn$newspaper
predict(eq3,newdata=ddn,interval="prediction",level=0.95)
