
# Comments ----------------------------------------------------------------

#I can write non-code comments by beginning a line with a hash symbol.
#This is really useful for verbally documenting what I'm doing,
#providing instructions, commenting on interesting results, etc.
#It can also be useful for "commenting out" a line of code
#that I want to save but do not want to run for some reason, for instance:
#oldmod <- lm(y ~ x1 + x2, data = olddat)

#Here's a useful comment for you all: 
#Check out the Global Options menu under Tools 
#if you would like to alter your RStudio appearance or other settings.

#Here's another useful comment:
#This is an R script, which is a list of lines of code 
#that I can tell R to run (sending the code down to the console below).
#I can modify and save this script as I please, so I don't lose my work
#and can come back to it later.


# Installing and loading packages -----------------------------------------

#For example:
install.packages("powerLATE")
library(powerLATE)


# You will all need to install the following ------------------------------

install.packages("rmarkdown")
install.packages("knitr")


# Simulated data ----------------------------------------------------------

var1 <- seq(1:6)
var2 <- c(4,8,15,16,23,42)
var3 <- rnorm(6)
var4 <- c("large","small","large","medium","medium","small")
simdat <- data.frame(var1,var2,var3,var4)
simdat


# Real data ---------------------------------------------------------------

dat <- read.csv("data_health_synth.csv")
names(dat)
head(dat)

dat$ldl_mean_t
hist(dat$ldl_mean_t)
