#' @import  shiny dplyr
#' @examples
#' library(shiny)
#'
#' ui <- fluidPage(
#'   chooseVarInput("data_list")
#' )
#'
#' server <- function(input, output, session) {
#'   chooseVarServer("data_list")
#' }
#'
#' shinyApp(ui, server)
#'
chooseVarInput <- function(id) {
  tagList(
    # datasetInput(NS(id,"data")),
    selectInput(NS(id, "select_var"), "Select Variable", choices = NULL, multiple = TRUE)
  )

}
chooseVarServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    # data <- datasetServer("data")
    observeEvent(data(), {
    shiny::updateSelectInput(session = session,
                      inputId = "select_var",
                      choices =  names(data()),
                      selected = names(data()))

    })
    
    reactive(data()[[input$select_var]])
    # reactive(get(input$dataset, "package:datasets"))
  })
}



