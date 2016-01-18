bootstrap <- function(data, statistic=median, k=400) {
  res <- numeric(k)
  for (i in 1:k) {
    # Create a resampling
    resample <- sample(1:length(data), replace=TRUE)
    # apply the statistic to that resampling
    val <- statistic(resample)
    # keep track of the results
    res[i] <- val
  }
  # give back the results
  return(res)
}