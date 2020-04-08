library(ggplot2)

lottery_plot <- function(dt) {
  Ex <- sum(dt$x * dt$px)
  
  ggplot(data = dt, aes(x = x, y = px)) +
    geom_bar(stat = "identity") +
    geom_vline(xintercept = Ex)
}

lottery_result <- function(params, dt) {
  Ex <- sum(dt$x * dt$px)
  
  cnts <-
    rmultinom(n = params["nGames"],
              size = params["nTickets"],
              prob = dt$px)
  totalWinnings <- apply(cnts, 2, function(cnt)
    sum(cnt * dt$x))
  avgWinnings <- totalWinnings / params["nTickets"]
  
  meanAvgWinnings <- mean(avgWinnings)
  stdAvgWinnings <- sd(avgWinnings)
  
  gameResult <-
    data.frame(t(cnts), totalWinnings, avgWinnings, Ex - avgWinnings)
  
  colnames(gameResult) <-
    c(paste('x =', dt$x, sep = ' '),
      'Total winnings',
      'Per ticket: mean(X)',
      '$E(X) - mean(X)$')
  rownames(gameResult) <-
    paste('Game', 1:params["nGames"], sep = ' ')
  
  result <- list(
    table = gameResult,
    Ex = Ex,
    meanAvgWinnings = meanAvgWinnings,
    stdAvgWinnings = stdAvgWinnings,
    meanDevFromEx = mean(Ex - avgWinnings)
  )

  return(result)
}
