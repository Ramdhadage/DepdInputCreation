# UI functions ----

## make_ui function -----
make_ui <- function(x, id, var) {
  if (is.numeric(x)) {
    rng <- range(x, na.rm = TRUE)
    sliderInput(id, var, min = rng[1], max = rng[2], value = rng)
  } else if (is.factor(x)) {
    levs <- levels(x)
    # selectInput(id, var, choices = levs, selected = levs, multiple = TRUE)
    shinyWidgets::pickerInput(
      inputId = id,
      label = var,
      choices = levs,
      selected =levs,
      multiple = TRUE
    )
  } else {
    # Not supported
    NULL
  }
}
# server functions ----
## filter_var  ----
filter_var <- function(x, val) {
  if (is.numeric(x)) {
    !is.na(x) & x >= val[1] & x <= val[2]
  } else if (is.factor(x)) {
    x %in% val
  } else {
    # No control, so don't filter
    TRUE
  }
}

## find_var
find_vars <- function(data, filter) {
  names(data)[vapply(data, filter, logical(1))]
}
