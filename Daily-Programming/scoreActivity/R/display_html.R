test_dir <- "/Users/kaplan/Downloads/MATH-253-01-Week 1 Assignment-20302"


# Display the submissions in a directory.

show_html <- function(directory=".") {
  r_files    <- list.files(path = directory, pattern = "[\\.r|\\.R|\\.rmd|\\.Rmd|\\.RMD]$")
  r_students    <- unique(gsub("_.*$", "", r_files))
  html_files <- list.files(path = directory, pattern = "\\.html$")
  html_students <- unique(gsub("_.*$", "", html_files))
  # ignore .r files for students with an html file
  need_r_file <- r_files[!r_students %in% html_students]
  all_files <- c(html_files, need_r_file)
  Scores <- data.frame(
    student_name = unique(gsub("_.*$", "", all_files)),
    score = 0,
    file = "x",
    score2 = 0,
    file2 = "x",
    stringsAsFactors = FALSE
  )
  for (file in all_files) {
    this_student <- gsub("_.*$", "", file)
    # deal with the possibility that there is more than one paper for this student
    grade_row <- which(Scores$student_name == this_student)
    score_name <- "score"
    file_name <- "file"
    if (Scores$score[grade_row] != 0) {
      score_name <- "score2"
      file_name <- "file2"
    }

    file_extension <- tools::file_ext(file)
    foo <- paste0('"', directory, "/", '"')
    if (tolower(file_extension) %in% "rmd") {
      # Compile the file to html
      html_file <- tempfile(fileext = "html")
      knitr::knit(input = file, output = html_file)
      system_command <- 
        paste0("open '", directory, "/", html_file, "'", collapse="")
    } else {
      system_command <- paste0("open '", directory, "/", file, "'", collapse="")
    }
    system(system_command)
    
    score <- menu(as.character(0:10), graphics=FALSE, title = this_student)
    Scores[[score_name]][grade_row] <- score
    Scores[[file_name]][grade_row] <- file
  }
  return (Scores)
}
