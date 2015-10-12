#' Score based on a set of conditions
#'
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


#' @export
score_set <- function(..., leave_out_names = NULL) {
  # Collect the dots into the set of expressions.
  res <- list()
  res$ldots <- lazy_dots(...)
  res$leave_out_names <- leave_out_names

  res
}

#' @export
print_test_results <- function(test_statements) {
  res <- find_score(test_statements)
  cat(res$comments)
}

#' @export
find_score <- function(test_statements) {
  ldots <- test_statements$ldots
  leave_out_names <- test_statements$leave_out_names
  score <- 0
  results <- NULL

  # look for all the names used in check statements
  object_names <- NULL
  for (k in seq_along(ldots)) {
    object_names <- c(object_names, all.names(ldots[k][[1]]$expr))
  }
  object_names <- setdiff(unique(object_names), leave_out_names)
  missing_names <- object_names[ ! sapply(object_names, FUN=exists)]

  for (k in seq_along(ldots)) {
    res <- try(lazy_eval(ldots[k])[[1]], silent=TRUE)
    if (inherits(res, "try-error")) {
      # no change in score
      results[k] <- paste("ERROR when running ", deparse(ldots[k][[1]]$expr))
    } else {
      # no problems running the statement
      score <- score + res$pts
      results[k] <- res$message
    }

  }
  if (length(missing_names > 0)) {
    results <- c(
      paste0("MISSING OBJECT",
             ifelse(length(missing_names)==1,": ","S: "),
             paste(missing_names, collapse=", ")),
      results
    )
  }
  list(score = score, comments = knitr::asis_output(paste0(results, collapse = "\n")))
}

#' Perform a test, returning the score and a message

#' @export
check <- function(match = TRUE, expr, message=NULL, pts=1) {
  wins <- FALSE
  if (inherits(match, "approx_amount")) {
    if( abs(expr - match$x) < match$pm ) wins <- TRUE
  } else {
    if (match == expr) wins <- TRUE
  }
  if (is.null(message)) message <- paste(deparse(substitute(expr)),collapse="\n")
  score <- ifelse(wins, pts, 0)
  flag <- ifelse(wins, "passed:", "FAILED:")

  list(pts=score, message = paste(flag, message), possible=pts)
}

#' @export
check_exists <- function(expr, pts=1) {
  message <- deparse(substitute(expr))
  value <- exists(message)
  list(pts=0 + pts*value,
       message = paste0(ifelse(value, "passed: ", "FAILED: "),
                       'object "',message,'" ',
                       ifelse(value,"exists", "doesn't exist.")),
       possible=pts)
}

#' Mark a quantity as reflecting an "about"
#' @export
about <- function(x, pm = abs(0.01*x)) {
  res <- list(x = x, pm = pm)
  class(res) <- "approx_amount"
  return(res)
}

#' @export
gives_error <- function(expr) {
  res <- try(expr, silent=TRUE)
  # TRUE OR FALSE for it threw an error
  inherits(res, "try-error")
}

