
library(shiny)
library(ggplot2)
library(tidyr)
library(plyr)
library(dplyr)
library(lubridate)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    dat1 <-read.csv("./Data/dat.csv", stringsAsFactors = FALSE)
    dat1[,1] <- mdy(dat1[,1])
    
    if (input$dataset == "Raw"){
      dat <- filter(dat1, Date >= input$dateRange[1] & Date <= input$dateRange[2] 
                    &  Level == input$level) 
      dat <- group_by(dat, Level)
      ggplot(dat, aes(x=Date, y=Value, colour=Level)) +
        geom_line() +
        scale_colour_brewer(palette="Set1")
    } else {
      dat <- filter(dat1, Date >= input$dateRange[1] & Date <= input$dateRange[2] 
                    &  Level == input$level) 
      dat <- group_by(dat, Level)
      dat <- mutate(dat, Percent_Change = ((Value/Value[1])-1)*100)
      
      ggplot(dat, aes(x=Date, y=Percent_Change, colour=Level)) +
        geom_line() +
        scale_colour_brewer(palette="Set1")
      
    }
    
    
  })
  
  
})
