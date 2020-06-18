# Starter ggplot function

plot_clicks <- function(input,ad_clicks, plot_type){
    
    plot_expr <- switch(input$plot_type,
                        scatter = ggplot2::geom_point(size = 4),
                        line = ggplot2::geom_line(size = 1.2),
                        both = list(ggplot2::geom_line(size = 1.2), 
                                    ggplot2::geom_point(size = 4))
    )
    
    ad_clicks %>% 
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
            x = "",
            y = "",
            title = ""
        ) + 
        ggplot2::guides(col = ggplot2::guide_legend(title = "")) + 
        ggplot2::theme(
            legend.position = "bottom"
        )
    
}