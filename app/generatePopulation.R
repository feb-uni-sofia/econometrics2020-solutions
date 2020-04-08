library(ggplot2)
library(dplyr)

set.seed(203434)
n <- 400
muX <- 14
sdX <- 5
x <- rnorm(n, muX, sdX)


y <- 100 + 0.45 * x + rnorm(n, 3)
