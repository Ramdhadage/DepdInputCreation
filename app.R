#' @import shiny purrr
filterApp <- function() {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        datasetInput("data", is.data.frame),
        textOutput("n"),
        chooseVarInput("choose_var"),
        filterUI("filter"),
      ),
      mainPanel(
        tableOutput("table")
      )
    )
  )
  server <- function(input, output, session) {
    df <- datasetServer("data")
    choose_var_data <- chooseVarServer("choose_var", data = df)


    filter <- filterServer("filter", df)
    
    output$table <- renderTable(df()[filter(),, drop = FALSE])
    output$n <- renderText(paste0(sum(filter()), " rows"))
  }
  shinyApp(ui, server)
}
filterApp()
