# ui.R

library(shiny)

# To label inputs, the section title is give first, followed by the section parameter
# i.e. hwe_p

# Initialize the layout with a navbar
shinyUI(
  
  navbarPage(title = "Quantitative Genetics Demo",
             
             # First tab
             tabPanel(title = "Introduction",
                      
                      titlePanel("Introduction"),
                            
                            mainPanel("Test"

                            )
                   ),
             
             # Second tab
             tabPanel("Hardy-Weinberg Equilibrium",
                      
                      titlePanel("Hardy-Weinberg Equilibrium"),
                            
                      # Create a sidebar panel
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # Help text
                          helpText("Test"),
                          
                          helpText("Description1"),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "hwe_p",
                                      "Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0.01,
                                      max = 0.99 ),
                          
                          helpText("Description1"),
                          
                          # Slider for number of individuals
                          sliderInput(inputId = "hwe_pop_size",
                                      "Breeding Population Size:",
                                      value = 100,
                                      min = 2,
                                      max = 2000 ),
                          
                          
                          helpText("Description1"),
                          
                          
                          # Slider for number of generations
                          sliderInput(inputId = "hwe_gen",
                                      "Number of Generations:",
                                      value = 200,
                                      min = 10,
                                      max = 1000 ),
                          
                          # Input for the number of population replications
                          numericInput(inputId = "hwe_reps",
                                       "Number of Replications",
                                       value = 3,
                                       min = 1,
                                       max = 5 ),
                          
                          # Break
                          br(),
                          
                          # Helptext
                          helpText("Click to run the simulation."),
                          
                          # Action button
                          actionButton(inputId = "hwe_action", label = "Simulate!")
                          
                        ),
                        
                        # main panel
                        mainPanel(
                        
                          # Add graph
                          plotOutput(outputId = "hwe_plot"),
                          
                          # Add table
                          tableOutput(outputId = "hwe_table")
                          
                        )
                      ) # End the sidebar layout
                      
              # End the tab        
             ),
             
             # Third tab
             tabPanel("Genetic Variance",
                      
                      titlePanel("Genetic Variance"),
                      
                      # Create a sidebar panel
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # Help text
                          helpText("Test"),
                          
                          helpText("Description1"),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "var_p",
                                      "Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0,
                                      max = 1 ),
                          
                          helpText("Description1"),
                          
                          # Slider for additive effect
                          sliderInput(inputId = "var_a",
                                      "Additive Effect (a):",
                                      value = 1, 
                                      min = 0, 
                                      max = 10 ),
                          
                          helpText("Description1"),
                          
                          # Slider for dominance effect
                          sliderInput(inputId = "var_d",
                                      "Dominance Effect (d):",
                                      value = 1, 
                                      min = 0, 
                                      max = 10 )
                          
                        ),
                        
                        mainPanel(
                          
                          # Add graph
                          plotOutput(outputId = "var_plot"),
                          
                          # Table
                          tableOutput(outputId = "var_table")
                          
                        )
                        
                      )
              
              # Close the tab        
             ),
             
             # Third tab
             tabPanel("Response to Selection",
                      
                      titlePanel("Response to Selection"),
                      
                      # Create a sidebar panel
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # Help text
                          helpText("Test"),
                          
                          helpText("Description1"),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "resp_p",
                                      "Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0,
                                      max = 1 ),
                          
                          helpText("Description1"),
                          
                          # Slider for number of genes
                          sliderInput(inputId = "resp_L",
                                      "Number of genes:",
                                      value = 20, 
                                      min = 1, 
                                      max = 100 ),
                          
                          helpText("Description1"),
                          
                          # Slider for heritability
                          sliderInput(inputId = "resp_h",
                                      "Heritability:",
                                      value = 0.5, 
                                      min = 0, 
                                      max = 1 ),
                          
                          helpText("Description1"),
                          
                          # Slider for selection intensity
                          sliderInput(inputId = "resp_i",
                                      "Selection Intensity:",
                                      value = 0.1, 
                                      min = 0, 
                                      max = 1 ),
                          
                          
                          helpText("Description1"),
                          
                          # Slider for population size
                          sliderInput(inputId = "resp_n",
                                      "Breeding Population Size:",
                                      value = 100,
                                      min = 2,
                                      max = 2000 ),
                          
                          helpText("Description1"),
                          
                          # Slider for number of generations
                          sliderInput(inputId = "resp_t",
                                      "Number of Breeding Generations:",
                                      value = 10, 
                                      min = 1, 
                                      max = 50 ),
                          
                          # Break
                          br(),
                          
                          # Helptext
                          helpText("Click to run the simulation."),
                          
                          # Action button
                          actionButton(inputId = "resp_action", label = "Simulate!")
                          
                          
                          
                        ),
                        
                        mainPanel(
                          
                          # Add graph
                          plotOutput(outputId = "resp_plot"),
                          
                          # Add another graph
                          plotOutput(outputId = "resp_supplot"),
                          
                          # Table
                          tableOutput(outputId = "resp_table")
                          
                        )
                        
                      )
             )
             
   # End the navigation bar
  )
  
) # End the UI
                                      
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
