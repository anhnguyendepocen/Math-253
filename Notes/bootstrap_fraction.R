#' Fraction left out of bootstrap
#' 
#' Estimated by Monte Carlo method, more details
#' @param sample_size an integer. How big the original sample is.
#' @param ntrials. The number of Monte Carlo runs to make. 
#' 
#' @export
left_out_fraction <- function(sample_size, ntrials = 100) {
  # Runs many trials (ntrials) and calculates the fraction left 
  # out of a bootstrap from that many trials.
  left_out_sum = 0
  for (k in 1:ntrials){
    left_out_sum <- 
      left_out_sum + left_out_of_bootstrap(sample_size)
  }
  
  return(left_out_sum / (ntrials * sample_size))
}

# helper function
left_out_of_bootstrap <- function(n) {
  n - length(unique(sample(1:n, replace = TRUE, n)))
}
