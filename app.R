# install.packages("genderdata", repos = "http://packages.ropensci.org")
library(genderdata)
library(shiny)
library(dplyr)
library(ggplot2)
library(ggthemes)

ui <- fluidPage(titlePanel(title = "names (1880-2012)"),
                textInput("name", "enter a name", value = "prince"),
                actionButton("go", "search"),
                plotOutput("plot1", brush = "plot_brush"),
                plotOutput("plot2"),
                htmlOutput("info")
                
)

server <- function(input, output) {
    
    dat <- eventReactive(input$go, {
        
        # filter ssa_national object that was loaded in genderdata package
        ssa_national %>%   
            filter(name == tolower(input$name)) %>%
            mutate(total = male + female)
        
    })
    
    output$plot1 <- renderPlot({
        
        ggplot(dat(), aes(year, total, col=name)) + 
            geom_line() + 
            xlim(1880,2012) +
            theme_minimal() +
            labs(list(title = "",
                      x = "year \n \n click-and-drag over the plot to 'zoom'",
                      y = "n individuals"))
        
    })
    
    output$plot2 <- renderPlot({
        
        # need latest version of shiny to use req() function
        req(input$plot_brush)
        brushed <- brushedPoints(dat(), input$plot_brush)
        
        ggplot(brushed, aes(year, total, col = name)) + 
            geom_line() +
            theme_minimal() +
            labs(list(title = "",
                      x = "year",
                      y = "n individuals"))
        
    })
    
    output$info <- renderText({
        
        "<p>data source: <a href='https://github.com/ropensci/genderdata'>social security administration names from genderdata package</a></p>"
        
    })
    
}

shinyApp(ui, server)