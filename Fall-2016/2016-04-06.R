firstD <- function(f, h = 0.001) {
  return(function(x) {(f(x + h) - f(x - h)) / (2 * h)})
}

secondD <- function(f, h = 0.001) {
  fprime = firstD(f, h = h)
  firstD(fprime)
}

penalty <- function(f, a = 0, b = 1, h = 0.001) {
  f2 <- function(x) abs(secondD(f, h = h)(x)^2)
  integrate(f2, a, b)
}