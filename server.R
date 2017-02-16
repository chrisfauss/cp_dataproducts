# Load library
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        # Create the reactive data set
        eco_car <- reactive({  
                # Define mtcars
                mtcars$car <- row.names(mtcars)
                mtcars <- mtcars[,c(12,1,4,9,10)]
                
                # Filter settings from input
                gears <- as.numeric(input$select_gear)
                hp <- as.numeric(input$slider_hp)
                trans <- as.numeric(input$radio_trans)
                distance <- as.numeric(input$dist)
                
                # Calculation of fuel usage  
                mtcars$total_gallons <- round(distance/mtcars$mpg,2)
                
                # Adapting the data set based on filters and sorting starting with lowest usage
                mtcars <- mtcars[mtcars$gear %in% gears & mtcars$hp >= hp & mtcars$am == trans,]
                mtcars <- mtcars[,c(1,2,3,5,6)]
                names(mtcars) <- c("Car","Miles/Gallon","Gross Horsepower","Gears","Total Gallons")
                mtcars <- mtcars[order(mtcars$`Total Gallons`),]
               
        }) 
        
        # Create the reactive top car        
        top_car <- reactive({
                eco_car()[1,1]
        })
                
        # Create table for output
                output$table <- renderDataTable({
                        eco_car()
                })
                
        # Create top car output
                output$topcar <- renderPrint({
                        top_car()
                })

    
  

  
})

