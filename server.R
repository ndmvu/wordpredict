options(shiny.maxRequestSize=30*1024^2)

library(shiny)
library(data.table)
library(NLP)
library(tm)

# Defining server logic needed for summarization and display of data
shinyServer(function(input, output) {    
    # Summarizing the dataset
    output$Original <- renderText({
        Orig_Input <- input$obs
        return(Orig_Input)
    })
    
    # Summarizing the dataset
    output$Translated <- renderText({
        Orig_Input <- input$obs
        Trans_Input <- Translate_Input(Orig_Input)
        return(Trans_Input)
    })
    
    # Summarizing the dataset
    output$BestPrediction <- renderText({
        Orig_Input <- input$obs
        Trans_Input <- Translate_Input(Orig_Input)
        BestPrediction_Output <- "The predicted next word will be here."
        Split_Trans_Input <- Split_Translate_Input(Orig_Input)
        Word_Count <- length(Split_Trans_Input)
        
        if(Word_Count==1){
            BestPrediction_Output <- Word_Count1(Split_Trans_Input)
        }
        if(Word_Count==2){
            BestPrediction_Output <- Word_Count2(Split_Trans_Input)
        }
        if(Word_Count==3){
            BestPrediction_Output <- Word_Count3(Split_Trans_Input)
        }
        if(Word_Count > 3){
            Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                                 Split_Trans_Input[Word_Count - 1],
                                 Split_Trans_Input[Word_Count])
            BestPrediction_Output <- Word_Count3(Words_to_Search)
        }
        return(BestPrediction_Output)
    })
    
    # Show the first "n" observations
    output$view <- renderTable({
        Orig_Input <- input$obs
        Split_Trans_Input <- Split_Translate_Input(Orig_Input)
        Word_Count <- length(Split_Trans_Input)
        
        if(Word_Count==1){
            BestPrediction_Output <- Word_Count1(Split_Trans_Input)
        }
        if(Word_Count==2){
            BestPrediction_Output <- Word_Count2(Split_Trans_Input)
        }
        if(Word_Count==3){
            BestPrediction_Output <- Word_Count3(Split_Trans_Input)
        }
        if(Word_Count > 3){
            Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                                 Split_Trans_Input[Word_Count - 1],
                                 Split_Trans_Input[Word_Count])
            BestPrediction_Output <- Word_Count3(Words_to_Search)
        }
      
        if(exists("AlternativeGuess", where = -1)){
            AlternativeGuess
        }else{
            XNgramsTable <- data.frame(Word=NA, Probability=NA)
        }
      
    })
})
