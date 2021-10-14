library(shiny)
library(dplyr)
library(ggplot2)

theme_set(theme_bw())

#Import COVID daily cases and cumulative for UK
cases <- read.csv("cases_d.csv")
tot <- read.csv("bynation_cases.csv")
vac <- read.csv("vc_data.csv")

#Show the structure of the data
str(cases)
str(tot)
str(vac)

#change the class of the date column to Date format
cases$date <- as.Date(cases$date, "%m/%d/%Y")
vac$date <- as.Date(vac$date, "%m/%d/%Y")

#This code is for UI of Shiny
ui <- fluidPage(
  
  #create header for the UI
  headerPanel('Coronavirus in the UK'),
  tags$br(),
  tags$br(),
  tags$br(),
  tags$br(),
  tags$br(),
  
  #create a drop down list to select the type of report
  selectInput("rep_y", "Select the type of report:",
              list(`UK Daily Confirmed Cases` = "1",
                   `UK Cumulative Cases` = "2",
                   `Total Cases By Nation` = "3",
                   `Fully Vaccinated` = "4")),
  
  
  
  tags$br(),
  tags$br(),
  
  #create a name for the plot
  plotOutput("p_daily")

)

server <- function(input, output){
  output$p_daily <- renderPlot({
    
   
    
  #plot cases by using ggplot2 package
    if(input$rep_y == '1'){
      ggplot(cases, aes(x=date, y=daily))+ geom_bar(stat="identity", width=.7, fill="#1ba4e3")+ labs(y="Daily Confirmed Cases", x = "Date")}
    
    else if(input$rep_y == '2'){
      ggplot(cases, aes(x=date, y=cumulative))+ geom_bar(stat="identity", width=.7, fill="#b53b07")+ labs(y="Cumulative Cases", x = "Date")}
    
    else if(input$rep_y == '3'){
      ggplot(tot, aes(x=areaName, y=cum))+ geom_bar(stat="identity", width=.7, fill="#1ba4e3")+ labs(y="Total Confirmed Cases", x = "Nation")}
    
    else {
      ggplot(vac, aes(x=date, y=d_num))+ geom_bar(stat="identity", width=.7, fill="#1ba4e3")+ labs(y="Daily", x = "Date")}
    
    
  })
  
}

shinyApp(ui = ui, server = server)
