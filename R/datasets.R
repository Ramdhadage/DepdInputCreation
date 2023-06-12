#' @import  shiny
#' @examples
#' library(shiny)
#'
#' ui <- fluidPage(
#'   datasetInput("data_list")
#' )
#'
#' server <- function(input, output, session) {
#'   datasetServer("data_list")
#' }
#'
#' shinyApp(ui, server)
#'
datasetInput <- function(id, filter = NULL) {
  names <- "warpbreaks"
    # ls("package:datasets")
  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }
  selectInput(NS(id, "dataset"), "Pick a dataset", choices = names)
}
datasetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive(get(input$dataset, "package:datasets"))
  })
}
