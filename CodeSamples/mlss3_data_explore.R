
# Simulated data ----------------------------------------------------------

var1 <- seq(1:6)
var2 <- c(4,8,15,16,23,42)
var3 <- rnorm(6)
var4 <- c("large","small","large","medium","medium","small")
simdat <- data.frame(var1,var2,var3,var4)
simdat
View(simdat)


# Real data ---------------------------------------------------------------

dat <- read.csv("data_health_synth.csv")
names(dat)
head(dat)
View(dat)
