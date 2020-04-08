## app.R ##
library(shinydashboard)
library(rhandsontable)
library(DT)

source('./normal_distribution/normal_distribution.R')


ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Lottery", tabName = "lottery", icon = icon("dashboard")),
      menuItem("Normal distribution", tabName = "normalDistribution", icon = icon("th"))
    )
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    withMathJax(),
    fluidRow(
      tabItems(
        # First tab content
        tabItem(tabName = "lottery",
                h1("Lottery"),
                fluidRow(
                  box(
                    title = "Controls",
                    p("You can change the probabilities and the value of each outcome in the table below. \n
                      Adjust the number of games and the number of tickets per game."),
                    rHandsontableOutput("hot"),
                    sliderInput("ticketsPerGame", "Number of tickets per game:", 1, 100, 50),
                    sliderInput("numberOfGames", "Number of games:", 1, 20, 5),
                  ),
                  box(
                    title = "Summary",
                    plotOutput("probBarChart"),
                    tableOutput("gamesTable"),
                    uiOutput("simulationSummary"),
                  )
                ),
        ),
        # Second tab content
        tabItem(
          tabName = "normalDistribution",
          h1("Normal distribution"),
          normalDistributionUi("normalDistributionSim"),
        )
      )
    )
  )
)
