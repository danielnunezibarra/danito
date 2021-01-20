library(shiny)
library(deSolve)

exTxt <-
    'This simple application allows you to simulate a zombie invasion! Using the sliders, you can see how changing certain values affects the zombie and human population.
See if you can use the sliders to make the humans beat the zombies by time 20! (Hint: you\'ll need to have the red line above the green line at time 20).'

fluidPage(
    
    ## Application title
    titlePanel("Zombies vs. Humans!"),
    
    sidebarLayout(
        ## Sidebar with a slider input
        sidebarPanel(
            sliderInput(
                "x",
                "Starting number of humans",
                value = 10,
                min = 1,
                max = 200,
                step = 1
            ),
            sliderInput(
                "y",
                "Starting number of zombies",
                value = 5,
                min = 1,
                max = 200,
                step = 1
            ),
            sliderInput(
                "alpha",
                "Human strength",
                value = 5,
                min = 0,
                max = 30,
                step = 0.1
            ),
            sliderInput(
                "beta",
                "Zombie strength",
                value = 5,
                min = 0,
                max = 100,
                step = 1
            ),
            sliderInput(
                "gamma",
                "Zombie cure rate",
                value = 5,
                min = 0,
                max = 10,
                step = 0.1
            ),
            sliderInput(
                "delta",
                "Zombie strength",
                value = 5,
                min = 0,
                max = 100,
                step = 1
            )
        ),
        
        ## Show a plot of the solution
        mainPanel(
            fluidRow(
                column(12, p(exTxt, style = "color:blue; font-size: 20px;"))
            ),
            fluidRow(
                column(6, plotOutput("timeline")),
                column(6, plotOutput("phase"))
            ),
            fluidRow(
                column(8, align = "center", imageOutput("winner")),
                column(4, align = "left", htmlOutput("winner_text"))
            )
        )
        
    )
    
    ## Change
    ## includeCSS("~/github/Website/css/app.css")
)