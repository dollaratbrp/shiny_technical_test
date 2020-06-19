library(shiny)
library(here)
library(dplyr)


# source(here("ggplot.R"))

shinyServer(function(input, output) {

    options(stringsAsFactors = FALSE)
    
    daterange<- eventReactive(input$submitbtn,{
        input$dateRange
    })
    
    plottype<- eventReactive(input$submitbtn, {
        input$plot_type
    })
        
    
    # Import data
    ad_clicks <- read.csv(here("ad_clicks.csv")) %>%
        mutate(day = as.Date(day))
    
    output$dateRange<- renderUI({
        dateRangeInput(inputId = 'dateRange')
    })
    
    plot_clicks <- function(ad_clicks, plot_type){
        
        plot_expr <- switch(plottype(),
                            scatter = ggplot2::geom_point(size = 4),
                            line = ggplot2::geom_line(size = 1.2),
                            both = list(ggplot2::geom_line(size = 1.2), 
                                        ggplot2::geom_point(size = 4))
        )
        ggplotly(
        ad_clicks %>% 
            dplyr::filter(day >= daterange()[1] &
                       day<= daterange()[2]) %>%
            dplyr::group_by(name, day) %>% 
            dplyr::summarise(clicks = sum(clicks)) %>% 
            dplyr::ungroup() %>% 
            ggplot2::ggplot(ggplot2::aes(x = day,
                                         y = clicks,
                                         col = name)) +
            plot_expr + 
            ggplot2::scale_x_date(date_breaks = "1 week",
                                  date_labels = "%d%b%Y") + 
            ggplot2::labs(
                x = "Day",
                y = "Number of Clicks",
                title = "Number of clicks per day by name"
            ) + 
            ggplot2::guides(col = ggplot2::guide_legend(title = "")) + 
            ggplot2::theme(
                legend.position = "bottom"
            ))
        
    }
    

    
    # Create plot output object
    output$plot <- renderPlotly({
        plot_clicks(ad_clicks)
    })

})
