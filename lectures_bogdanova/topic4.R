# Import data ----
rm(list=ls())
# http://faculty.marshall.usc.edu/gareth-james/ISL/data.html
dd=read.csv("https://raw.githubusercontent.com/feb-uni-sofia/econometrics2020-solutions/master/data/Advertising.csv",na.strings=c(""," ","NA"), stringsAsFactors = F)
dd$sales=dd$sales*1000

# Estimate parameters of LR ----
eq=lm(sales~TV, data=dd)
eq$coefficients
summary(eq)
# Construct 95%-CI, test of significance, R squared ----
confint(eq,level=0.95)
confint(eq,level=0.99)
summary(eq)
names(summary(eq))
summary(eq)$r.squared
cor(dd$sales,dd$TV)^2
# Prediction ----
predict(eq,newdata = data.frame(TV=c(50,60,70)),interval="prediction",level=0.95)
