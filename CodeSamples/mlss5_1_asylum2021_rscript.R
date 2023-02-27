
# Some info ---------------------------------------------------------------

#This source code file is a simple R script.
#It contains R code that I can get the console
#to execute for me and tell me the results,
#which I can then copy or figure out how to print.
#However, this code file will not render a nice
#presentation of my results.


# Loading data ------------------------------------------------------------

dat <- read.csv("europe_asylum_2021.csv")


# Inspecting data ---------------------------------------------------------

head(dat)
unique(dat$geo)


# Computing some statistics -----------------------------------------------

mean(dat$napps)
sum(dat$napps)


# Some visualization ------------------------------------------------------

hist(dat$napps, breaks = 15)

