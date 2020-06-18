library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Ad Clicks Visualizer"),

    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "plot_type",
                label = "Plot Type",
                choices = c("line", "scatter", "both"),
                selected="both",
                inline = TRUE
            ),
            dateRangeInput('dateRange',
                           label="Select a date range")
        ),

        mainPanel(
            plotOutput("plot")
        )
    )
))
