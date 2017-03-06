#' Plot a population
#' 
#' @param pop_df A data.frame of generations and allele frequencies
#' @param pause The length of the system pause, in seconds.
#' 
#' 
plot_pop <- function(pop_df, pause = 0.05) {
  
  # Create an empty plot
  plot(NA, type = "b", ylim = c(0,1), xlim = c(1, nrow(pop_df)),
       main = "Allele Frequency Over Generations", ylab = expression(p),
       xlab = "Generation")

  # Loop over generations
  for (t_i in seq(nrow(pop_df))) {
  
    lines(x = pop_df[seq(t_i), "gen"], y = pop_df[seq(t_i), "p"])
    
    Sys.sleep(pause)
    
  }
  
} # Close the function





