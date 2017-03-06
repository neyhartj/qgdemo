# server.R

library(shiny)

# Source the code
source("source.R")

shinyServer(function(input, output) {
  
  # Run the simulation using inputs
  hwe_datasetInput <- eventReactive(eventExpr = input$hwe_action, valueExpr = {
  
    # Run a simulation given the inputs
    p <- input$hwe_p
    t <- input$hwe_gen
    N <- input$hwe_pop_size
    r <- input$hwe_reps
    
    # Return a list a results
    list(
      p = p,
      t = t,
      N = N,
      r = r,
      results = simpop(p = p, N = N, t = t, reps = r)
    )
    
  })
    
  # Plot the simulation
  output$hwe_plot <- renderPlot({
    
    data_set <- hwe_datasetInput()
    
    # Plot
    plot(NA, xlim = c(0,data_set$t), ylim = c(0,1), main = "Allele Frequencies Under Random Mating",
         xlab = "Generation", ylab = "Allele Frequency (p)")
    # Color scheme
    col.scheme <- rainbow(n = data_set$r)
    
    for (i in seq(data_set$r)) {
      lines(x = data_set$results$gen, y = data_set$results[,i+1], col = col.scheme[i])
    }
    
    # Add legend
    legend("bottomleft", legend = paste("Pop", seq(data_set$r)), col = col.scheme, lwd = 2)

  })
  
  # Add table
  output$hwe_table <- renderTable({
    
    # Read-in the dataset input
    data_set <- hwe_datasetInput()
    
    data.frame(
      Rep = paste("Pop", seq(data_set$r)),
      Final_Allele_Frequency = as.numeric(data_set$results[data_set$t,-1]),
      Fixation_Generation = apply(X = data_set$results[,-1], MARGIN = 2, FUN = function(gen) 
        ifelse(any(gen == 0), which(gen == 0)[1], NA)), 
      
      row.names = NULL
    )
    
  })
  
  
  ## Genetic variance tab
  # Wait for input
  
  var_datasetInput <- reactive({
    
    # Extract the variables
    p <- input$var_p
    a <- input$var_a
    d <- input$var_d
    q <- 1 - p
    
    # Calculate additive variance
    V_A <- 2 * p * q * ( ( a + d * (q - p) )^2 )
    V_D <- 4 * p^2 * q^2 * d^2
    
    # Total V_G is V_A + V_D
    V_G_tot <- V_A + V_D
    V_G_per <- 1
    
    # Calculate proportions of V_A and V_D
    V_G_prop <- matrix(data = c(V_A, V_D), ncol = 1) / V_G_tot
    
    list(
      V_A = V_A,
      V_D = V_D,
      V_G_per = V_G_per,
      V_G_prop = V_G_prop
    )
    
  })
  
  # Plot
  output$var_plot <- renderPlot({
    
    # Get the data
    var_out <- var_datasetInput()
    
    # Plot
    bp <- barplot(height = var_out$V_G_prop, horiz = TRUE, beside = FALSE, 
                  main = "Partition of Genetic Variance",
                  xlab = expression(Proportion~of~V[G]), col = rainbow(n = 2),
                  legend.text = T)
    
    # Position of text
    text_y <- apply(X = var_out$V_G_prop, MARGIN = 2, FUN = cumsum)
    text_y <- text_y - (var_out$V_G_prop/2)
    
    # Add labels
    text(x = t(text_y), y = bp, labels = c(expression(bold(V[A])), expression(bold(V[D]))) )
    
  })
  
  # Table
  output$var_table <- renderTable({
    
    # Get the data
    var_out <- var_datasetInput()
    
    # Output data.frame
    data.frame(
      Source_of_Variance = c("Additive", "Dominance"),
      Value = c(var_out$V_A, var_out$V_D),
      Proportion_of_Genetic_Variance = var_out$V_G_prop
    )
    
  })
  
  
  # Response to selection
  # Wait for input
  resp_datasetInput <- eventReactive(eventExpr = input$resp_action, valueExpr = {
    
    # Extract variables
    p <- input$resp_p
    L <- input$resp_L
    h <- input$resp_h
    i <- input$resp_i
    N <- input$resp_n
    t <- input$resp_t
    
    # Determine the additive effects of QTL
    a <- ((L - 1) / (L + 1)) ^ seq(L)
    
    # If a is 0 (L = 1), set to 1
    a <- ifelse(a == 0, 1, a)
    
    # Determine the max genetic value
    max_G <- sum(a)
    
    # Launch simulation
    # Return a list a results
    list(
      p = p,
      L = L,
      h = h,
      i = i,
      t = t,
      N = N,
      a = a,
      max_G = max_G,
      results = simbreed(p = p, N = N, t = t, h = h, L = L, i = i, a = a)
    )
    
  })
  
  # Plot
  output$resp_plot <- renderPlot({
    
    # Get the data
    resp_out <- resp_datasetInput()
    
    # Plot
    plot(x = resp_out$results$gen, y = resp_out$results$G, type = "l", 
         main = "Genotypic Value Over Generations", ylab = "Genotypic Value", 
         xlab = "Generation", ylim = c(-1, 1), lwd = 2.5, col = "blue")
    
  })
  
  # Plot other
  output$resp_supplot <- renderPlot({
    
    # Get the data
    resp_out <- resp_datasetInput()
    
    # Generations
    gen <- resp_out$results$gen
    
    # Genetic variance over generations
    varG <- resp_out$results$varG
    # matrix of allele frequencies
    freq <- resp_out$results[,startsWith(x = colnames(resp_out$results), prefix = "p"), drop = FALSE]
    # Vector of allele effects
    a <- resp_out$a
    
    # bins of allele effects
    a_bin <- .bincode(x = a, breaks = seq(0, 1, by = 0.1))
    
    
    # 2 plots
    par(mfrow = c(1, 2))
    
    plot(x = gen, y = varG, type = "l", main = "Genetic Variance Over Generations", 
         ylab = "Genetic Variance", xlab = "Generation", lwd = 2.5,
         col = "red")
    
    # Plot for allele frequencies
    plot(NA, type = "l", main = "Allele Frequencies Over Generations",
         ylab = "Frequency", xlab = "Generation", ylim = c(0, 1), xlim = c(1, length(gen)))
    
    # Iterate over allele frequencies
    for (l in seq(resp_out$L)) {
      
      lines(x = gen, y = freq[,l], lwd = a_bin[l] / 2)
      
    }
    
  })
  
  
}) # Close the server
