MyData <- data.frame(
  x = runif(100, max = 70, min = 20)
)
MyData$y <- 5 + 3 * MyData$x + rnorm(100, mean=0, sd=2)

# plot(y ~ x, data = MyData)

LL_line <- function(params, data) {
  # m, a slope
  # b, an intercept
  # sigma, a standard deviation
  m <- params[1]
  b <- params[2]
  sigma <- params[3]
  resid <- with(data, y - (m * x + b))
  LLikes <- dnorm(resid, mean= 0 , sd=sigma, log = TRUE)

  return( sum(LLikes) )
}

LL_line(params = c(3, 5, 2), data = MyData)

optim(c(2,2,5), LL_line, 
      control = list(fnscale = -1), 
      data = MyData)

# The taxicabs

load(url("http://tiny.cc/dcf/Taxi_trips.rda"))


taxi_likelihood <- function(params, data){
  base_fare <- params[1]
  per_mile <- params[2]
  params <- params[3]
  resid <- with(data, 
                fare_amount - 
                  (base_fare + per_mile * trip_distance))
  Likes <- dexp(resid, rate = 1/params) + 0.001
  
  sum(log(Likes))
}

result <- optim(c(3.0378809, 0.9208041, 7.8247615), taxi_likelihood, 
      data=Taxi_trips, control = list(fnscale=-1))

plot(fare_amount ~ trip_distance, data = Taxi_trips)
abline(result$par[1], result$par[2], col="red", lwd = 3)


# if you're a student, nothing; otherwise $100/month

if (Default[k,]$student == "Yes") {
  0
} else {
  100
}

you_pay <- ifelse(Default$student == "Yes"  , 0  , 100 )

you_pay <- ifelse(Default$student == "Yes"  , 0  , 0.1 * Default$balance )

you_pay <- ifelse(Default$student == "Yes"  , 
                  0,
                  ifelse(Default$balance < 10*Default$income, 
                         0.1 * Default$balance,
                         0.05 * Default$income))

bigger_one <- with(Default,
                   ifelse(balance > income, balance, income))


if (sum(Default$balance) > 100000 && mean(Default$balance) > 5000) {
  stop("Too much!")
} else {
  100
}


truth <- c(2.8e-5, 5.8e-4, .0061, .026, .089, .32, .55)
theory <- c(2.87e-4, .0026, .022, .072, .16, .36, .38)

sum((truth / theory)) - length(truth)

max(abs(cumsum(truth) - cumsum(theory)))
