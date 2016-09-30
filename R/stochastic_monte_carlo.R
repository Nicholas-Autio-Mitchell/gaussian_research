
###################### ================================================================================== ######################
######################  Use linear combinations of Gaussians to create desired moments of a distribution  ######################
###################### ================================================================================== ######################

## ================================== ##
##  Require packages for this script  ##
## ================================== ##

library(quantmod)                       #get stock data
library(data.table)                     #manipulate the data
library(moments)                        #compute moment

## ================================== ##
##  Get market data for th Dow Jones  ##
## ================================== ##

## Get market data
getSymbols("^DJI")
## Extract just the adjusted return in log form
dow <- as.data.table(diff(log(DJI[,6]))) %>% .[2:nrow(.), 2 , with=FALSE]
setnames(dow, names(dow), "Dow")

## ===================================================================== ##
##  Create function that compputes the first four moments of a Gaussian  ##
## ===================================================================== ##

moments <-function(input){

    output <- matrix(data = 0, nrow = 4, ncol = 1)
    
    output[1] <- mean(input)
    output[2] <- var(input) 
    output[3] <- skewness(input)  
    output[4] <- kurtosis(input)
    
    return(output)
}

## The moments of the Dow data
dow_mom <- moments(dow$Dow)

## ================================== ##
##  Create 20 Gaussian distributions  ##
## ================================== ##

## The different values for the mean, each is unique
vals_avg <- seq(-3, 3, length.out = 20)
## Use one value for the sandard deviation
vals_sd <- 0.10
#vals_sd <- dow_mom[2]        # or use the variance of the dow log returns

## Create object to hold simulated Gaussians
sim_ret <- as.data.table(matrix(data = 0, nrow = nrow(dow), ncol = 20))

## simulate the distributions
num_periods <- nrow(dow)
for(i in 1:length(vals_avg)) {
    sim_ret[, i] <- rnorm(num_periods, mean = vals_avg[i], sd = vals_sd) 
    
}

## Generate some weights - two different versions
w1 <- c(2, 2, 3, 4, 4, 4, 6, 7, 10, 12, 9, 9, 5, 4, 4, 4, 6, 2, 2, 1)/100 # percentages
#w2 <- seq(0, 100, length.out = 20)/1000

sum(w1)    #1
length(w1) #20
## sum(w2)    #1
## length(w2) #20

## ==================================== ##
##  An approach to Monte Carlo methods  ##
## ==================================== ##

## shuffle the weights at random and use them to weight each of the 20 different simulated data sets
## Perform this many times and find best result according to your needs

## Create the final Gaussian (according to Theroem's from Bernstein and Skitovitch)
sim_data <- as.matrix(sim_ret)          #makes it easier

## How many times to run it, 1000 takes ~20 seconds (using one core)
num_sim <- 1000                         #provides up to 2e18 unique combinaions of weights

## Object to store the weights used the the moments that were created
results <- sapply(paste0("result", seq(1, num_sim)), function(x) NULL)
step_reults <- sapply(c("weights", "moments", "returns"), function(x) NULL)
for(i in 1:num_sim){results[[i]] <- step_reults}

## set the seed for reproducibility
set.seed(789)

## Run all simulations, recording the weights used and resulting moments for each run 
for(j in 1:num_sim) {                   #number of simulations

    ## Take a new order of the weights
    this.weight <- sample(w1, 20)       

    ## Create matrix to hold the weighted average for each period
    this.returns <- matrix(data = NA, nrow = nrow(sim_data), ncol = 1)

    for(i in 1:nrow(sim_data)) {        #take weighted avg of for each row using weights

        this.returns[i] <- crossprod(sim_data[i,], this.weight) #weights each row and sums it up
    }
        
    results[[j]][[1]] <- this.weight           #recorsd the weighs used
    results[[j]][[2]] <- moments(this.returns) #records moments
    results[[j]][[3]] <- this.returns          #saved actual returns    
    
}

##collect all moments - first create objects
sim_mu <- matrix(NA, num_sim, 1)
sim_var <- matrix(NA, num_sim, 1)
sim_skew <- matrix(NA, num_sim, 1)
sim_kurt <- matrix(NA, num_sim, 1)
## Extract
for(i in 1:num_sim){sim_mu[i] <- results[[i]][[2]][[1]]}
for(i in 1:num_sim){sim_var[i] <- results[[i]][[2]][[2]]}
for(i in 1:num_sim){sim_skew[i] <- results[[i]][[2]][[3]]}
for(i in 1:num_sim){sim_kurt[i] <- results[[i]][[2]][[4]]}
## Put into one data table
output_mom <- as.data.table(Reduce(cbind, list(sim_mu ,sim_var, sim_skew, sim_kurt)))
setnames(output_mom, names(output_mom), new = c("Mean", "St.Dev", "Skew", "Kurt"))
## Inspect output by descending values of the moments
output_mom[order(-Mean)]                  #mean
output_mom[order(-St.Dev)]                #variance
output_mom[order(-Skew)]                  #skewness
output_mom[order(-Kurt)]                  #kurtosis
## Order them all one after another
## Perhaps useful to search for a specific value
output_mom[order(-Mean, -St.Dev, -Skew, -Kurt)]


## ================== ##
##  Plot the results  ##
## ================== ##
## A novel plot using the colour and size of the data points to represent the Skew and Kurtosis
mom_plot <- ggplot(data = output_mom, aes(x = Mean, y = St.Dev)) +
    geom_point(aes(size = Kurt, colour = Skew, alpha = 0.02)) +
    scale_size(range = c(1,3)) +
    ggtitle("The first four moments for 1000 simulations\nEach simulation represents a linear combination of twenty Gaussians")

## Save to disk
ggsave(filename = "weighted_gaussians.png", plot = mom_plot)

## ========== ##
##  comments  ##
## ========== ##

#' In order to create different moments, the user must edit the various input parameters such as the weights used
#' or the base distributions that are then used to create the final linear combination
#' 
#' the weights could be altered incrementally over a grid of values until the desired moments are found

## ===================================== ##
##  A second approach to the weightings  ##
## ===================================== ##
## Instead of sampling a different order from the same weightings each time,
#' we could generate 20 new weights each time

## A function to generate 20 random numbers that sum to 1
rand.gen <- function(n) { #input n specifies how many sets of twenty random numbers to generate
    
    m <- matrix(runif(20*n,0,1), ncol=20)
    m<- sweep(m, 1, rowSums(m), FUN="/")

    return(m)
    
}


###################### ========================================================= ######################
######################  Import results of Excel work combining twenty Gaussians  ######################
###################### ========================================================= ######################

## File must be in working directory!
x <- read.table(file = "twenty_gaussians_raw_output.txt", sep = "\n", stringsAsFactors = FALSE)
x1 <- as.data.table(x)
x1[, data := as.numeric(V1)]
## First line may have been interpreted as a header
x1$data[1]  <- -0.030463629             #insert actual value from file

## Extract just the numbers
g20 <- x1[, .(data)]
## Plot a histogram
g20_plot <- ggplot(data = g20, aes(data)) +
    geom_density(show.legend = FALSE, colour = "#000099") +
    scale_x_continuous(breaks = c(-0.15, -0.10, -0.05, 0.00, 0.05, 0.10, 0.15, 0.20 )) +
    ggtitle("Density plot of the weighted combination of twenty Gaussian distributions") +
    xlab("Returns") +
    ylab("Density") +
    theme_bw()

## Have a look
g20_plot

## Save
ggsave(filename = "excel_20_gaussians.png", plot = g20_plot)
