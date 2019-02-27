# Exercise 2: a basic Shiny app

# Load the `shiny` package


# Define a new `ui` variable. This variable should be assigned a `fluidPage()` layout
# The `fluidPage()` layout should be passed the following:
calc_ui <- fluidPage(
  
  # A `titlePanel()` layout with the text "Cost Calculator"
  titlePanel(
    "Cost Calculator"
  ),
  
  # A `numericInput()` widget with the label "Price (in dollars)"
  # It should have a default value of 0 and a minimum value of 0
  # Hint: look up the function's arguments in the documentation!
  numericInput(
    inputId = "price",
    label = "Price (in dollars)",
    value = 0,
    min = 0,
    step = 0.25
  ),
  
  # A second `numericInput()` widget with the label "Quantity"
  # It should have a default value of 1 and a minimum value of 1  
  numericInput(
    inputId = "quantity",
    label = "Quantity",
    value = 1,
    min = 1,
    step = 1
  ),
  
  # The word "Cost", strongly bolded
  p(strong("Cost")),
  
  # A `textOutput()` output of a calculated value labeled `cost`
  textOutput(outputId = "total_cost")
)

# Define a `server` function (with appropriate arguments)
# This function should perform the following:
calc_server <- function(input, output) {
  
  # Assign a reactive `renderText()` function to the output's `cost` value
  # The reactive expression should return the input `price` times the `quantity`
  # So it looks nice, paste a "$" in front of it!
  output$total_cost <- renderText({
    price <- input$price * input$quantity
    paste0("Total Cost $", price)
  })
  
}

# Create a new `shinyApp()` using the above ui and server
shinyApp(ui = calc_ui, server = calc_server)
