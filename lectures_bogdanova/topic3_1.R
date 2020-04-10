# Assoc. Prof. Boryana Bogdanova, PhD, Sofia University
# Import data ----
# http://faculty.marshall.usc.edu/gareth-james/ISL/data.html
rm(list=ls())

dd=read.csv("https://raw.githubusercontent.com/feb-uni-sofia/econometrics2020-solutions/master/data/Advertising.csv",na.strings=c(""," ","NA"), stringsAsFactors = F)

# Make a table of two variables only
dd.new=data.frame(Y=dd$sales*1000,X=dd$TV)
attach(dd.new)
# Visualize data via a scatterplot
windows()
plot(X,Y,pch=19,col="blue",main="Sales vs. TV budget")


# Estimation of the correaltion coefficient ----

# Write down the forulas presented at the slides
n=nrow(dd.new)
xbar=mean(X)
ybar=mean(Y)
cv=sum((X-xbar)*(Y-ybar))/(n-1)
Sx=sqrt(sum((X-xbar)^2)/(n-1))
Sy=sqrt(sum((Y-ybar)^2)/(n-1))
r=cv/(Sx*Sy)
# Significance test ----
# Let's find an estimate of the correlation coefficient for two unrealted variables
set.seed(5)
x1=rnorm(100)
y1=rnorm(100)
windows()
plot(x1,y1,pch=19,col="blue",main="Sales vs. TV budget")
cor(x1,y1)
# Calculate the test statistics for the estimated correlation coeffcient of 0.78
t=(r*sqrt(n-2))/sqrt(1-r^2)
qt(0.025,df=n-2)
qt(0.975,df=n-2)
# [-1.97,1.97]
# Perform the built-in test:
cor.test(X,Y)
