# Compile all the daily programming activities with both answers and no answers

# get the list of files
knit_with_answers <- function(pattern = "Day-[0-9]{2}-Programming-Task.Rmd") {
  rmd_files <- dir(pattern = pattern)
  for (file in rmd_files) {
    output_file = paste0("Solution-", file)
    output_file = gsub(".Rmd$", ".pdf", output_file)    
    rmarkdown::render(file, 
                      params = list(show_answers = TRUE),
                      output_file = output_file,
                      envir = new.env()
                    )
    output_file = gsub(".Rmd$", ".pdf", file)    
    rmarkdown::render(file, 
                      params = list(show_answers = FALSE),
                      output_file = output_file,
                      envir = new.env()
    )
  }
}