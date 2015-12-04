
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyFiles)

shinyUI(fluidPage(

  # Application title
  titlePanel("Grading Papers"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      actionButton("get_dir", "Choose assignment directory:"),
      textOutput("pwd"),
      selectInput("which_student", 
                  "Select student:", 
                  choices = "No directory specified yet."),
      radioButtons("which_file",
                  "Select file:",
                  choices = c("None yet."= 1)),
      radioButtons("score", "Score", 
                   choices = c("NA", 0:10), inline = TRUE),
      textInput("comment", "Comments for student:", value = "None yet.", width = "100px"), 
      actionButton("save_score", "Save score")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(id = "displays", selected = "R",
                  tabPanel("HTML",
                    wellPanel(id = "html_display",
                              style = "overflow-y:scroll; max-height: 600px",
                              htmlOutput("html_display"))),
                  tabPanel("RMD",
                           pre(textOutput("rmd_display"))),
                  tabPanel("R",
                           pre(textOutput("r_display")))
      )
    )
  )
))
