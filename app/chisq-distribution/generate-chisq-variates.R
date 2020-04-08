
A <- cbind(
  c(1, 1, 1),
  c(0, 1, 0),
  c(0, 0, 1)
)

a <- c(0, 1, 1)

solve(A)
solve(A) %*% a
  