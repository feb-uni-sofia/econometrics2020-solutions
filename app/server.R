library(ggplot2)

source('./lottery/plot_lottery.R')
source('./normal_distribution/normal_distribution.R')

server <- function(input, output, session){
  df <- data.frame(x=c(0, 1, 2), px=c(0.5,0.3,0.2))
  values <- reactiveValues(data = df)
  
  observe({
    if(!is.null(input$hot)){
      values$data <- as.data.frame(hot_to_r(input$hot))
      # print(values$data)
      output$hot <- renderRHandsontable({
        rhandsontable(values$data, colHeaders = c('x', 'p(x)'), rowHeaders = NULL)
      })
      
      discreteGameResult <- lottery_result(params = c(nGames = input$numberOfGames, nTickets = input$ticketsPerGame), values$data)
      
      output$simulationSummary <- renderUI({
        validate(
          need(sum(values$data$px) == 1, 'The probabilities in p(x) need to sum to 1.')
        )
        result <- lottery_result(params = c(nGames = input$numberOfGames, nTickets = input$ticketsPerGame), values$data)
        
        withMathJax(
          paste("Expected value of the game is $$E(X) = ",
                paste(values$data$x, values$data$px, sep = " \\times ", collapse = " + "),
                " = ",
                discreteGameResult$Ex, "$$", ".",
                "The average per ticket value (averaged over ",
                input$numberOfGames ," game", ifelse(input$numberOfGames > 1, "s", ""), "): ",
                sprintf("%.3f", discreteGameResult$meanAvgWinnings), ". ",
                "The standard deviation ot the per ticket wins was ",
                sprintf("%.3f", discreteGameResult$stdAvgWinnings), ".", sep = "")
        )
      })
      
      output$gamesTable <- renderTable({
        return(discreteGameResult$table)
      })
    }
  })
  
  output$hot <- renderRHandsontable({
    rhandsontable(values$data, colHeaders = c('x', 'p(x)'), rowHeaders = NULL)
  })
  
  callModule(normalDistribution, "normalDistributionSim")
  
  output$probBarChart <- renderPlot({
    lottery_plot(values$data)
  })
}




