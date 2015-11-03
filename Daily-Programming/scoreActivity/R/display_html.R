# Display the submissions in a directory.

show_html <- function(directory=".") {
  r_files    <- list.files(path = directory, pattern = "\\.[r|R|rmd|Rmd|RMD]$")
  r_students    <- unique(gsub("_.*$", "", r_files))
  html_files <- list.files(path = directory, pattern = "\\.html$")
  html_students <- unique(gsub("_.*$", "", html_files))
  # ignore .r files for students with an html file
  need_r_file <- r_files[!r_students %in% html_students]
  all_files <- c(html_files, need_r_file)
  Scores <- data.frame(
    student_name = unique(gsub("_.*$", "", all_files)),
    scores = 0
  )
  for (file in all_files) {
    file_extension <- tools::file_ext(file)
    if (tolower(file_extension) %in% "rmd") {
      # Compile the file to html
      html_file <- tempfile(fileext = "html")
      knitr::knit(input = R_file, output = html_file)
      sys.call(paste0("open '", html_file, "'", collapse=""))
    } else {
      sys.call(paste0("open '", file, "'", collapse=""))
    }
    this_student <- gsub("_.*$", "", file)
    menu(as.character(0:10), graphics=FALSE, title = this_student)

  }

}
