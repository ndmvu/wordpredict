

library(shiny)

# Defining user interface for the app
shinyUI(fluidPage(
  
    # Application title.
    titlePanel("Predict Next Word"),
  
    sidebarLayout(
        sidebarPanel(
            textInput("obs", "Please Enter Text Here:"),
            
            helpText("The Application will be using entered text to predict next word."),
            
            submitButton("Predict")
        ),
      
      mainPanel(
          h3("The text you entered is:"),
          textOutput("Original"),
          br(),
          h3("The entered text is reformated as following:"),
          textOutput("Translated"),
          br(),
          br(),
          h3("The Predicted Next Word is:"),
          div(textOutput("BestGuess"), style = "color:red"),
          br(),
          h3("This Application has predicted the next word on basis of following statistics/probability:"),
          tableOutput("view")
    )
  )
))
