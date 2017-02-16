
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Find the most economic car for your trip"),
  
  # Sidebar with filters 
  sidebarLayout(
    sidebarPanel(
        h3("Instructions"),
        "This shiny app provides a list of cars (from mtcars data set) based on different filter settings. 
        Based on the desired travel distance and under consideration of the filters set 
        the car with the least total gallons for the trip is recommended at the top. 
        Below a list of all cars which match the filter are listed, sorted in most economic order.",
        br(),
        br(),
        em("Recommended steps:"),
        br(),
        em("1. Enter the travel distance"),
        br(),
        em("2. Select the desired filter"),
        br(),
        em("3. Find most economic car in the main pain"), 
        br(),
        em("4. (Optional) Check list for all cars fitting the criteria"),
        numericInput("dist", label = h3("Enter your distance in miles"), value = 100),
        radioButtons("radio_trans", label = h3("Transmission"), choices = list("Automatic" = 0, "Manual" = 1), selected = 0),
        checkboxGroupInput("select_gear", label = h3("Gears"), choices = list("3" = 3, "4" = 4, "5" = 5), selected = 3),
        sliderInput("slider_hp", label = h3("Minimum Horsepower"), min = 0, max = max(mtcars$hp), value = 100)
       
    ),
    
    # Show top car and other tables
    mainPanel(
            h3("This is the most economic car for your trip:"),
            verbatimTextOutput("topcar"),
            br(),
            h3("Detailed list of cars"),
            dataTableOutput("table")
    )
  )
))
