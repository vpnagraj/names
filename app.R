library(shiny)
library(ggplot2)
library(ggthemes)
library(babynames)
library(scales)

options(scipen=999)

ui <- fluidPage(titlePanel(title = "names (1880-2012)"),
                textInput("name", "enter a name"),
                actionButton("go", "search"),
                plotOutput("plot1", brush = "plot_brush"),
                plotOutput("plot2"),
                htmlOutput("info")
                
)

server <- function(input, output) {
    
    dat <- eventReactive(input$go, {
        
        subset(babynames, tolower(name) == tolower(input$name))
        
    })
    
    output$plot1 <- renderPlot({
        
        ggplot(dat(), aes(year, prop, col=sex)) + 
            geom_line() + 
            xlim(1880,2012) +
            theme_minimal() +
            # format labels with percent function from scales package
            scale_y_continuous(labels = percent) +
            labs(list(title ="% of individuals born with name by year and gender",
                      x = "\n click-and-drag over the plot to 'zoom'",
                      y = ""))
        
    })
    
    output$plot2 <- renderPlot({
        
        # need latest version of shiny to use req() function
        req(input$plot_brush)
        brushed <- brushedPoints(dat(), input$plot_brush)
        
        ggplot(brushed, aes(year, prop, col=sex)) + 
            geom_line() +
            theme_minimal() +
            # format labels with percent function from scales package
            scale_y_continuous(labels = percent) +
            labs(list(title ="% of individuals born with name by year and gender",
                      x = "",
                      y = ""))
        
    })
    
    output$info <- renderText({
        
        "<p>data source: <a href='https://github.com/hadley/babynames'>social security administration names from babynames package</a></p>"
        
    })
    
}

shinyApp(ui, server)