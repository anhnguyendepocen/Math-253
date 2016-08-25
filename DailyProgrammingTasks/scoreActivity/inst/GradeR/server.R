# An application for viewing and scoring RMD/HTML/R files
library(shiny)
library(shinyFiles)

State <- reactiveValues()
Where <- reactiveValues()

shinyServer(function(input, output, session) {

  # Start by selecting the directory for grading
  State$the_directory <- "~/Downloads/Math-253-Student-Papers/253-Week-6-Assignment" # dirname(file.choose())
  
  observe({
    if (input$get_dir == 0 ) return()
    cat("Directory button value ", input$get_dir, "\n")
    dir_name <- dirname(file.choose())
#    browser()
    isolate(State$the_directory <<- dir_name) # Where$directory <<- dir_name
    isolate(setup_score_data_frame())
  })
  
  # update the list of students, displaying their current scores
  # in the dropdown menu
  update_student_choices <- reactive({
    if (length(isolate(State$students)) > 0) {
      student_choices <- isolate(State$students)
      names(student_choices) <- paste(student_choices, State$scores$score)
      # figure out which student is currently selected and
      # update to match with the new label showing the new score
      current_choice <- student_choices[grepl(input$which_student, student_choices)]
      updateSelectInput(session, "which_student", choices = student_choices)
      updateSelectInput(session, "which_student", selected = current_choice)
    }
  })
  
  # Initialize scores data frame 
  setup_score_data_frame <- reactive({
    # input$get_dir # for the dependency
    score_format <- data.frame(student = " ", score = 0, 
                             file = 0, time = date(), 
                             comment = "",
                             stringsAsFactors = FALSE)[-1,]
    output$pwd <- renderText(isolate(State$the_directory))
    files <- list.files(path = isolate(State$the_directory), 
                        pattern = "[\\.r|\\.R|\\.rmd|\\.Rmd|\\.RMD|\\.html|\\.pdf]$")
    State$students <- unique(gsub("_.*$", "", files))
    student_choices <- isolate(State$students)
  


    State$files <- file.info(paste0(isolate(State$the_directory),
                                    "/",
                                    files))
    score_file <- list.files(path = isolate(State$the_directory), pattern = "Scores.csv")

    if (length(score_file) == 1) State$scores <- 
      read.csv(paste(State$the_directory, score_file, sep = "/"), 
               stringsAsFactors = FALSE)
    else State$scores <- score_format

    State$scores <- merge(isolate(State$scores), 
                          data.frame(student = isolate(State$students)), all.y = TRUE)
    update_student_choices()
}) 

  # Observer for change in score
  observe({
    if (input$save_score == 0) return()

    isolate({
      ind <- get_student_score_index()
      State$scores$score[ind] <- input$score
      State$scores$time[ind] <- date()
      State$scores$file[ind] <- get_file_to_display()
      State$scores$comment[ind] <- input$comment
      write.csv(State$scores, 
                file=paste(State$the_directory, "Scores.csv", sep = "/"), 
                row.names = FALSE)
      update_student_choices()
    })
  })
  
  
  # Observer for when the selected student changes
  observe({
    if (input$which_student == "No directory specified yet.") return()
    student_name <- get_student_name()
    if (is.null(student_name)) return() 
    data_for_this_student <- subset(isolate(State$scores), student == student_name)
    if (nrow(data_for_this_student) > 0 ) selected_score = data_for_this_student$score[1]
    else selected_score = "NA"

    selected_score <- ifelse(is.na(selected_score), "NA", selected_score)
    updateRadioButtons(session, "score", selected = selected_score)
    display_student_file()
  })
  
  get_student_name <- reactive({
    this_student <- input$which_student
    return(
      ifelse(this_student == "No directory specified yet.",
             NA,
             this_student
      )
    )
  })
  
  get_student_score_index <- reactive({
    which(State$students == get_student_name())
  })
  
  get_student_files <- reactive({
    student <- get_student_name()
    if (is.na(student)) return(NULL)
    
    student_files <- subset(State$files, grepl(student, rownames(State$files), fixed = TRUE))
    choices <- 1:nrow(student_files)
    names(choices) <- paste(tools::file_ext(rownames(student_files)), student_files$time)
    updateRadioButtons(session, "which_file", choices = choices, select = 1)
    return(student_files)
  })
  
  get_file_to_display <- reactive({
    return(rownames(get_student_files())[as.integer(input$which_file)])
  })
      
  display_student_file <- reactive({ 
      file_name <- get_file_to_display()
      file_type <- tolower(tools::file_ext(file_name))
      if (file_type == "pdf") {
        system(paste0("open '", file_name, "'"))
        return()
      }
      if (file_type == "zip") {
        warning("ZIP file encountered")
        return()
      }
      con <- file(file_name, open = "rt", raw = TRUE)
      contents <- readLines(con)
      close(con)
    
      html_contents <- rmd_contents <- r_contents <- "" # display nothing
      if (file_type == "html") {
        html_contents <- contents
        output$html_display <- renderText(HTML(html_contents))
        tab_to_show <- "HTML"
      } else if (file_type == "r") {
        r_contents <- contents
        output$r_display <- renderText(paste(r_contents, collapse = "\n"))
        tab_to_show <- "R"
      } else if (file_type == "rmd") {
        rmd_contents <- contents
        output$rmd_display <- renderText(paste(rmd_contents, collapse = "\n"))
        tab_to_show <- "RMD"
      }

      updateTabsetPanel(session, "displays", selected = tab_to_show) 
    })
  
})
