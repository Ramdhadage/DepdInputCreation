#' @importFrom shiny NS
# filterUI function -----
filterUI <- function(id) {
  uiOutput(NS(id, "controls"))
}

filterServer <- function(id, df) {
  stopifnot(is.reactive(df))

  moduleServer(id, function(input, output, session) {
    vars <- reactive(names(df()))

    output$controls <- renderUI({
      purrr::map(vars(), function(var) make_ui(df()[[var]], NS(id, var), var))
    })

    reactive({
      each_var <- purrr::map(vars(), function(var) filter_var(df()[[var]], input[[var]]))
      purrr::reduce(each_var, `&`)
    })
  })
}
