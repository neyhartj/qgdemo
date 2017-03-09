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
                            
                            mainPanel(
                              
                              helpText("The complexity of quantitative genetics often requires intensive computation tools for analysis. Researchers can also use computers to run simulations of breeding programs. These can be especially informative for hypothesis testing or for decision-making in breeding. We will use simulations to better-understand the concepts of population genetics, genetic variance, and response to selection."),
                              
                              br(),
                              
                              h2("Learning Objectives"),
                              
                              helpText("After completing this demo, you should be able to..."),
                              h5("  Understand how allele frequencies change over time in randomly-mating populations"),
                              h5("  Define genetic drift and understand the impact of genetic drift on breeding populations."),
                              h5("  Define the relationship between population size and the likelihood that alleles reach fixation"),
                              h5("  Understand the relationship between allele frequency and coded genotypic values on the levels of additive variance and dominance variance."),
                              h5("  Understand the relationship between response to selection, genetic variance, and allele frequencies."),
                              h5("  Define the impact of heritability and selection intensity on response to selection."),
                              
                              br(),
                              
                              h2("Navigation"),
                              
                              helpText("This demo is very much 'point and click.' Click on the different tabs above to change the topic. Use the sliders to adjust the values of different parameters. Click the 'Simulate' button to run the simulations for topics 1 and 3."),
                              
                              br(),
                              
                              h4("Click on the first tab to begin!")

                            )
                   ),
             
             # Second tab
             tabPanel("Randomly-Mating Populations",
                      
                      titlePanel("Randomly-Mating Populations"),
                            
                      # Create a sidebar panel
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # Help text
                          helpText("This simulation will look at the changes in allele frequency for a single gene in a randomly-mating population."),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "hwe_p",
                                      "Starting Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0.01,
                                      max = 0.99 ),
                          
                          # Slider for number of individuals
                          sliderInput(inputId = "hwe_pop_size",
                                      "Breeding Population Size:",
                                      value = 100,
                                      min = 2,
                                      max = 2000 ),
                          
                          
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
                          helpText("This simulation will assess the impact of allele frequency and coded genotypic values on the level of genetic variance at a single gene."),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "var_p",
                                      "Starting Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0,
                                      max = 1 ),
                          
                          # Slider for additive effect
                          sliderInput(inputId = "var_a",
                                      "Additive Effect (a):",
                                      value = 1, 
                                      min = 0, 
                                      max = 10 ),
                          
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
                          helpText("In this simulation, we will explore how different parameters impact the response to selection and other measurements for a trait influenced by many genes."),
                          
                          # Slider for p allele frequency
                          sliderInput(inputId = "resp_p",
                                      "Starting Allele Frequency (p):",
                                      value = 0.5,
                                      min = 0,
                                      max = 1 ),
                          
                          # Slider for number of genes
                          sliderInput(inputId = "resp_L",
                                      "Number of genes:",
                                      value = 20, 
                                      min = 1, 
                                      max = 100 ),
                          
                          # Slider for heritability
                          sliderInput(inputId = "resp_h",
                                      "Heritability:",
                                      value = 0.5, 
                                      min = 0, 
                                      max = 1 ),
                          
                          helpText("The selection intensity here is defined as the proportion of individuals selected from one generation to create the population in the next generation. A low proportion of selected individuals (e.g. 0.1) is a high selection intensity, and vice versa."),
                          
                          # Slider for selection intensity
                          sliderInput(inputId = "resp_i",
                                      "Selection Intensity:",
                                      value = 0.1, 
                                      min = 0, 
                                      max = 1 ),
                          
                          # Slider for population size
                          sliderInput(inputId = "resp_n",
                                      "Breeding Population Size:",
                                      value = 100,
                                      min = 2,
                                      max = 2000 ),
                          
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
                                      
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
