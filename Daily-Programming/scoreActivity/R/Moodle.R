#' Grade Moodle repositories
#'
#'

grade_moodle <- function(moodle_dir, test_dir, test_file) {
  student_files <- list.files(moodle_dir, pattern = "\\.[r|R|rmd|Rmd|RMD]$")
  # Get the students' names
  Scores <- data.frame(
    student_name = gsub("_.*$", "", student_files),
    scores = 0
  )
  # strip off the last / (if any) from the directory
  moodle_dir <- gsub("/$", "", moodle_dir)
  test_dir   <- gsub("/$", "", test_dir)
  full_names <- paste(moodle_dir, student_files, sep="/")
  test_name  <- paste(test_dir,   test_file,     sep="/")
  this_dir   <- getwd()
  for (k in seq_along(full_names)) {
    cat(paste("\n\n", Scores$student_name[k]," for assignment ", test_file, "\n"))
    R_file <- full_names[k]
    # What kind of file is it?
    file_extension <- tools::file_ext(R_file)
    if (tolower(file_extension) %in% "rmd") {
      # Compile the file to .r
      r_file <- tempfile(fileext = "r")
      purl(input = R_file, output = r_file)
      R_file <- r_file
    }
    this_env <- new.env()
    setwd(tempdir()) # in a new directory for each student.
    try(sys.source(file = R_file, envir = this_env), silent = TRUE)
    try(sys.source(file = test_name, envir = this_env), silent = TRUE)
    res <- eval(parse(text="scoreActivity::find_score(Test_Statements)"),
                envir = this_env)
    Scores$scores[k] <- res$score
    setwd(this_dir)
  }

  Scores
}
