library(shiny)
library(deSolve)

server <- function(input, output){
    
    ## Function to current solution of LV
    lvModel <- function(t, state, pars) {
        with(as.list(c(state, pars)), {
            dx <- alpha * x - beta * x * y
            dy <- delta * x * y - gamma * y
            return(list(c(dx, dy)))
        })
    }
    
    times <- seq(0, 20, length = 201)
    
    soln <- reactive({
        init_state <- c(x = input$x, y = input$y)
        given_pars <- c(alpha = input$alpha / 10,
                        beta = input$beta / 100,
                        gamma = input$gamma / 10,
                        delta = input$delta / 100)
        deSolve::ode(init_state, times, lvModel, given_pars)
    })
    
    output$timeline <- renderPlot({
        out <- soln()
        ## opar <- par(mfrow = c(1, 2))
        matplot(out[ , 1], out[ , 2:3], type = "l",
                xlab = "Time", ylab = "Numbers",
                main = "", lwd = 2, lty = 1,
                col = c("green", "red"), bty = "l")
        legend("topright", c("Humans", "Zombies"),
               col = c("green", "red"), lty = 1, lwd = 2, bty = "n")
        ## polygon(out[, 2], out[, 3])
        ## par(opar)
    })
    
    output$phase <- renderPlot({
        out <- soln()
        n <- nrow(out)
        plot(out[, 2], out[, 3], xlab = "Humans", ylab = "Zombies",
             pch = 16, bty = "l")
    })
    
    output$winner <- renderImage({
        out <- soln()
        n <- nrow(out)
        if (out[n, 2] > out[n, 3]) {
            ## Humans won!
            list(src = "www/he-man.png",
                 contentType = "image/png",
                 alt = "Humans win!",
                 height = 250)
        } else {
            ## Zombies won!
            list(src = "www/zombie.png",
                 contentType = "image/png",
                 alt = "Zombies win!",
                 height = 250)
        }
    }, deleteFile = FALSE)
    
    output$winner_text <- renderText({
        out <- soln()
        n <- nrow(out)
        if (out[n, 2] > out[n, 3]) {
            return("<span style = 'color:green; font-size: 30px;'>Humans win!</span>")
        } else {
            return("<span style = 'color:red; font-size: 30px;'>Zombies win!</span>")
        }
    })
    
}