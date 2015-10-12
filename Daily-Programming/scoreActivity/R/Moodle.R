#' Grade Moodle repositories
#'
#'

grade_moodle <- function(moodle_dir, test_dir, test_file) {
  student_files <- list.files(moodle_dir, pattern = "\\.[r|R|rmd|Rmd|RMD]$")
  # Get the students' names
  Scores <- data.frame(
    student_names = gsub("_.*$", "", student_files),
    scores = 0
  )
  # strip off the last / (if any) from the directory
  moodle_dir <- gsub("/$", "", moodle_dir)
  test_dir   <- gsub("/$", "", test_dir)
  full_names <- paste(moodle_dir, student_files, sep="/")
  test_name  <- paste(test_dir,   test_file,     sep="/")
  for (k in seq_along(full_names)) {
    R_file <- full_names[k]
    this_env <- new.env()
    setwd(tempdir()) # in a new directory for each student.
    try(sys.source(file = R_file, envir = this_env), silent = TRUE)
    try(sys.source(file = test_name, envir = this_env), silent = TRUE)
    res <- eval(parse(text="scoreActivity::find_score(Test_Statements)"),
                envir = this_env)
    Scores$scores[k] <- res$score
  }

  Scores
}
