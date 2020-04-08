
normalDistributionUi <- function(id, label="Normal distribution") {
  ns <- NS(id)
  
  return(tagList(
    fluidRow(
      box(
        title = "Controls",
        p("Choose expected value, standard deviation and sample size."),
        sliderInput(ns("mu"), "Expected value (mu):", -3, 3, 0, 0.5),
        sliderInput(ns("sigma"), "Standard deviation (sd):", 0.7, 3, 1, 0.5),
        sliderInput(ns("a"), "a", -3, 3, 1),
        sliderInput(ns("b"), "b", -3, 3, 2),
        sliderInput(ns("n"), "Sample size", 1, 20, 5),
        sliderInput(ns("B"), "Number of samples", 1, 20, 5),
      ),
      box(
        plotOutput(ns("plot")),
        tableOutput(ns("samples"))
        # uiOutput(ns("formulas"))
      )
    )
  ))
}

normalDistribution <- function(input, output, session) {
  
  getValues <- reactive({
    return(list(
      mu = input$mu,
      sig = input$sigma,
      a = input$a,
      b = input$b,
      n = input$n,
      B = input$B
    ))
  })
  
  observe({
    v <- getValues()
    mu <- v$mu
    sig <- v$sig
    a <- v$a
    b <- v$b
    
    
    output$plot <- renderPlot({
      xrange <- c(-5, 5)
      xgridA <- seq(xrange[1], a, length.out = 60)
      xgridB <- seq(b, xrange[2], length.out = 60)
      
      ggplot(data = data.frame(x = xrange), aes(x = x)) +
        ylim(c(0, 0.7)) +
        stat_function(fun = dnorm, args = list(mean = mu, sd = sig)) +
        scale_color_discrete(name = "Probability") +
        geom_ribbon(
          data = data.frame(x = xgridA, ymin = 0, ymax = dnorm(xgridA, mean = mu, sd = sig )),
          aes(x=x, ymin=ymin, ymax=ymax, fill = paste("P(X < ", a, ")", sep = "")),
          alpha = 0.5
        ) +
        geom_ribbon(
          data = data.frame(x = xgridB, ymin = 0, ymax = dnorm(xgridB, mean = mu, sd = sig)),
          aes(x=x, ymin=ymin, ymax=ymax, fill = paste("P(X > ", b, ")", sep = "")),
          alpha = 0.5,
        )
    })
  })
  
  observe({
    v <- getValues()
    print(v)
    
    mu <- v$mu
    sig <- v$sig
    a <- v$a
    b <- v$b
    n <- v$n
    B <- v$B
    
    output$samples <- renderTable({
      xMtx <- matrix(rnorm(n * B, mean = mu, sd = sig), nrow = B, ncol = n)
      xSampleMeans <- apply(xMtx, 1, mean)
      xSampleSd <- apply(xMtx, 1, sd)
      
      sampleNr <- sampleNr <- 1:n  
      dt <- as.data.frame(cbind(sampleNr, xSampleMeans, xSampleSd, xMtx))
      colnames(dt) <- c("Sample", "Avg", "StdDev", paste("y", 1:n, sep = ""))
      
      return(dt)
    })
  })
}
