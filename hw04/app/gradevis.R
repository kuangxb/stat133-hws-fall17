#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggvis)
library(dplyr)
source('../code/functions.r')
clean_dat <- read.csv('../data/cleandata/cleanscores.csv')
clean_dat$Grade = factor(clean_dat$Grade,
                         levels = c('A+', 'A', 'A-',
                                    'B+', 'B', 'B-',
                                    'C+', 'C', 'C-',
                                    'D', 'F'))
colNames <- colnames(clean_dat[1:22])



ui <- fluidPage(
  
  titlePanel("Grade Visualizer"),
  
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected == 1",
                       h3('Grade Distribution'),
                       tableOutput('table')),
      conditionalPanel(condition = 'input.tabselected == 2',
                       selectInput('var1', "X-axis variable", colNames, 
                                    selected = "HW1"),
                       sliderInput('width', 'Bin Width',
                                   min = 1, max = 10, value = 10)),
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput('var2', "X-axis variable", colNames, 
                                   selected = "Test1"),
                       selectInput('var3', "Y-axis variable", colNames, 
                                   selected = "Overall"),
                       sliderInput('opacity', 'Opacity',
                                   min = 0, max = 1, value = .5),
                       radioButtons("line", label = h3("Show line"),
                                    choices = list("none" = 1, 
                                                   "lm" = 2, 
                                                   "loess" = 3)))
    ),  
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  tabPanel('Histogram', value = 2,
                           ggvisOutput('histogram'),
                           'Summary Statistics',
                           verbatimTextOutput('summ')),
                  tabPanel("Scatterplot", value = 3, 
                           ggvisOutput("scatterplot"),
                           'Correlation:',
                           textOutput('corr')),
                  id = 'tabselected')
    )
  )
)

server <- function(input, output) {
  grade_freq <- clean_dat[24]
  grade_freq <- grade_freq%>% group_by('Grade')%>% count(Grade)
  grade_freq$Prop <- round(grade_freq$n/334,2) 
  grade_freq <- grade_freq[2:4]
  grade_freq <- grade_freq%>% rename(Freq = n)
  
  output$table <- renderTable({
    grade_freq})
  
  vis_barchart <- reactive({
    clean_dat %>% 
      ggvis(x = ~Grade, fill = "blue")%>%
      layer_bars()
  })
  
  vis_barchart %>% bind_shiny("barchart")
  
  vis_histogram <- reactive({
    var1 <- prop('x', as.symbol(input$var1))
    clean_dat%>%
      ggvis(x = var1, fill := 'blue', stroke := 'gold') %>%
      layer_histograms(width = input$width)
  })
  
  vis_histogram %>% bind_shiny('histogram')
  
  summaries <- reactive({
    print_stats(summary_stats(clean_dat[[input$var1]]))
  })
  
  output$summ <- renderPrint({
    summaries()
  })
  vis_scatter <- reactive({
    var2 <- prop('x', as.symbol(input$var2))
    var3 <- prop('y', as.symbol(input$var3))
    
    if (input$line == 1){
      clean_dat%>%
        ggvis(x = var2,y = var3, opacity := input$opacity, 
              stroke := 'red')%>%
        layer_points()
    }
    else if (input$line == 2){
      clean_dat%>%
        ggvis(x = var2,y = var3, opacity := input$opacity, 
              stroke := 'red')%>%
        layer_points()%>% layer_model_predictions(model = 'lm', se = TRUE)
    }
    else if (input$line == 3){
      clean_dat%>%
        ggvis(x = var2,y = var3, opacity := input$opacity,
              stroke := 'red')%>%
        layer_points()%>% layer_smooths()
    }
  })
  
  vis_scatter %>% bind_shiny('scatterplot')
  
  correlation <- reactive({
    (cor(clean_dat[[input$var2]], clean_dat[[input$var3]]))
  })
  output$corr <- renderText({
    correlation()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

