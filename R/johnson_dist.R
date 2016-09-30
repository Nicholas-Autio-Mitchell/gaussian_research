###################### ========================================== ######################
######################  Create a distribution with given moments  ######################
###################### ========================================== ######################

#' We get the Dow returns, measure their moments and plot a histogram.
#' Then we fit a Johnson distribution to the data and fit that over the histogram
#'
#' The Johnson parameters can then be used to simulate new data
#'
#' Still not sure how best to make the comparison of returns depending on moments
#'
#' Compare returns of a portfolio based on a standard normal curve to those returned by our simulated data
#' that has moments very close to the dow?
#' This means we are comparing simulated data to standard normal data - we know the moments of the
#' simulated data are not standrad normal and we know they are representative of market returns


library(moments)

## get some market data
getSymbols("^DJI")
## Extract just the adjusted closing prices
dow_raw <- as.data.table(diff(log(na.locf(DJI[,6]))))[2:nrow(DJI)]

names(dow_raw) <- c("Date", "Dow.Lreturns")

## Record the moments of the data
dow.stats <- c(`mean` = mean(dow_raw$Dow.Lreturns),
               `var` = var(dow_raw$Dow.Lreturns),
               `skew` = skewness(dow_raw$Dow.Lreturns),
               `kurtosis` = kurtosis(dow_raw$Dow.Lreturns))

dow <- dow_raw$Dow.Lreturns

## Plot the log returns
hist(dow, freq = FALSE,
     breaks = 100, xlim = c(-0.1, 0.1))

## Fit the Johnson parameters to our data
dow.parms <- JohnsonFit(dow, moment = "quant")

## Print out the parameters 
sJohnson(dow.parms)

## Add Johnson distribution over the histogram
plot(function(x)dJohnson(x,dow.parms), min(dow), max(dow), add=TRUE, col="red")

## ===================================================== ##
##  Generate some new data using the Johnson Parameters  ##
## ===================================================== ##

## A new distribution with same size as our dow data
sim_dow <- rJohnson(length(dow), dow.parms)

sim.parms <- JohnsonFit(sim_dow, moment = "quant")

sim.stats <- c(`mean` = mean(sim_dow),
               `var` = var(sim_dow),
               `skew` = skewness(sim_dow),
               `kurtosis` = kurtosis(sim_dow))

## Plot the simulated returns
hist(sim_dow, freq = FALSE, breaks = 200, xlim = c(-0.1, 0.1))

## Add a line showing the Johnson fit over the simulated data
plot(function(x)dJohnson(x,sim.parms), min(sim_dow), max(sim_dow), add=TRUE, col="red")
## Add the Johnson fit found for the original market data
plot(function(x)dJohnson(x,dow.parms), min(dow), max(dow), add=TRUE, col="green")

## ============================================================================================= ##
##  Create some standard normal market returns with the same mean and var as our simulated data  ##
## ============================================================================================= ##

sim_st <- rnorm(length(sim_dow), mean = sim.stats[1], sd = sim.stats[2])

st.stats <- c(`mean` = mean(sim_st),
              `var` = var(sim_st),
              `skew` = skewness(sim_st),
              `kurtosis` = kurtosis(sim_st))

## Alter the sim_st data to match the mean and var of the sim. market data
st_ <- (sim_st - st.stats[1]) / st.stats[2]
