#' Score a daily activity in Math 253
#'
#' This function is specifically designed for Fall 2015
#'
#' @param day.  The day of the activity.  This identifies which test
#' statements are to be used.
#'
#' @export
score253 <- function(day) {
  if (missing(day)) stop("Must specify the day as an argument, e.g. day = 14")
  day <- as.numeric(day)
  if (is.na(day)) stop("day = ", day, "doesn't look like a number!")
  day <- if (day < 10 ) paste0("0",day) else as.character(day)
  git_location <- "https://raw.githubusercontent.com/dtkaplan/Math-253/master/"
  test_file <- paste0("Daily-Programming/Day-",day,"-Test-Statements.R")
  cat("--------\nRunning test statements for day ", day, "\n\n")
  tests <- textConnection(RCurl::getURL(paste0(git_location, test_file)))
  source(tests)
  close(tests)

#  source(paste0(git_location, test_file))
  }
