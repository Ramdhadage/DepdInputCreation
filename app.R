#' @import shiny purrr
filterApp <- function() {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        datasetInput("data", is.data.frame),
        textOutput("n"),
        filterUI("filter"),
      ),
      mainPanel(
        tableOutput("table")
      )
    )
  )
  server <- function(input, output, session) {
    df <- datasetServer("data")
    filter <- filterServer("filter", df)

    output$table <- renderTable(df()[filter(), , drop = FALSE])
    output$n <- renderText(paste0(sum(filter()), " rows"))
  }
  shinyApp(ui, server)
}
filterApp()
