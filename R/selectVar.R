#' @importFrom shiny NS
selectVarInput <- function(id) {
  selectInput(NS(id, "var"), "Variable", choices = NULL)
}

selectVarServer <- function(id, data, filter = is.numeric) {
  moduleServer(id, function(input, output, session) {
    observeEvent(data(), {
      updateSelectInput(session, "var", choices = find_vars(data(), filter))
    })

    reactive(data()[[input$var]])
  })
}
