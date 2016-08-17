
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("US Consumer Price Index"),
  dateRangeInput("dateRange",
                 label = 'Date range input:',
                 start = min(dat1[,1]), end = max(dat1[,1]),
                 format = "dd/mm/yyyy"
  ),
  
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose Data Type:", 
                  choices = c("Raw", "Trend")),
      
      checkboxGroupInput("level", "Geographic Level:",
                         choices = unique(dat1$Level),
                         selected = c("US","Northeast", "Southwest", "West", "South", "Midwest")),
      
      helpText("Data BLS CPI - Not Seasonally Adjusted")
      
      
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
      
    )
  )
))
