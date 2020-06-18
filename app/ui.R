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
                           label="Select a date range",
                           start=as.Date('2019-05-01'), end= as.Date('2019-06-10'),
                           min= as.Date('2019-05-01'), max= as.Date('2019-06-10')),
            actionButton("submitbtn","Submit")
        ),

        mainPanel(
            plotlyOutput("plot")
        )
    )
))
