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
        
        # create total number of records per year to calculate proprotion
        d <- ssa_national %>%
            group_by(year) %>%
            summarise(n = n())
        
        # filter ssa_national object that was loaded in genderdata package
        # join with object created above and calculate proportion
        ssa_national %>%   
            filter(name == tolower(input$name)) %>%
            mutate(total = male + female) %>%
            left_join(d) %>%
            mutate(prop = total / n) 
        
    })
    
    output$plot1 <- renderPlot({
        
        ggplot(dat(), aes(year, prop, col=name)) + 
            geom_line() + 
            xlim(1880,2012) +
            theme_minimal() +
            labs(list(title ="% of individuals born with name by year",
                      x = "\n click-and-drag over the plot to 'zoom'",
                      y = ""))
        
    })
    
    output$plot2 <- renderPlot({
        
        # need latest version of shiny to use req() function
        req(input$plot_brush)
        brushed <- brushedPoints(dat(), input$plot_brush)
        
        ggplot(brushed, aes(year, prop, col = name)) + 
            geom_line() +
            theme_minimal() +
            labs(list(title ="% of individuals born with name by year",
                      x = "",
                      y = ""))
        
    })
    
    output$info <- renderText({
        
        "<p>data source: <a href='https://github.com/ropensci/genderdata'>social security administration names from genderdata package</a></p>"
        
    })
    
}

shinyApp(ui, server)